//
//  EventDataCoordinator.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 14/06/2026.
//

import Foundation
import SwiftData
import Combine

// USAGE: Separating the controller and data persistence from View Model

@MainActor
class EventDataCoordinator: ObservableObject {
    @Published var savedEvents: [EventModel] = []
    
    // MARK: - API data from the DTO and mapped event data populates the events array (MOVE FROM VIEW MODEL)
    @Published var events: [EventModel] = []
    @Published var isLoading: Bool = false
    @Published var apiError: String? = nil
    
    // Initialise model context not a private var
    var modelContext: ModelContext?
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
//        print("[DEBUG] EventDataCoordinator initialised with SwiftData")
    }
    
    init() {
        self.modelContext = nil
//        print("[DEBUG] ventDataCoordinator initialized without SwiftData")
    }
    
    // MARK: - Fetch Events from API
    func fetchEventsFromAPI() async {
        isLoading = true
        apiError = nil
        do {
            let apiService = EventAPIService()
            let ticketmasterEvents = try await apiService.fetchArtEventsInLondon()
            let mapped = ticketmasterEvents.compactMap { EventModel(from: $0) }
            self.events = mapped
        } catch {
            self.apiError = error.localizedDescription
        }
        isLoading = false
    }
    
    // MARK: Refactor selectedEvent - now a function not a property
    
    func selectedEvent(for id: UUID) -> EventModel? {
        savedEvents.first { $0.event_id == id }
    }
    
//    var selectedEvent: EventModel? {
//        savedEvents.first { $0.event_id == self.eventID) }
//    } REFACTOR - DEFINE EVENTID WITH A FUNCTION

    func createEvent(_ event: EventModel) {
        savedEvents.append(event)
    }

    func updateEvent(_ updated: EventModel) {
        if let index = savedEvents.firstIndex(where: { $0.event_id == updated.event_id }) {
            savedEvents[index] = updated
        }
    }

    func deleteEvent(id: UUID) {
        savedEvents.removeAll { $0.event_id == id }
    }
    
    
    // MARK: - Persistence and debug prints
    // Save the current model context to persistent storage
    private func saveContext() {
        guard let modelContext = modelContext else {
//            print("[ERROR] saveContext: No modelContext - changes not persisted")
            return
        }
        do {
            try modelContext.save()
//            print("[DEBUG] saveContext: Context saved successfully")
        } catch {
//            print("[ERROR] Failed to save context: \(error.localizedDescription)")
        }
    }
}



