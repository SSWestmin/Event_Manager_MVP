//
//  EventDataCoordinator.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 14/06/2026.
//

import Foundation
import SwiftData
import Combine


// USAGE: Handles API fetching and SwiftData persistence for event data.
// Acts as a data service layer, managing create, update, delete, and query operations.
// Publishes event collections and loading state for consumption by the ViewModel.

// REFACTOR: Coordinator should be stateless


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
            // MARK: Debug prints for mapped events location logic
            // print("[DEBUG] Mapped events count: \(mapped.count)")
            // for event in mapped {
            //     print("[DEBUG] \(event.eventName) - lat: \(event.latitude), lon: \(event.longitude)")
            // }
            self.events = mapped

        } catch {
            self.apiError = error.localizedDescription
        }
        isLoading = false
    }
    
    // MARK: Refactored as a function
    //    var selectedEvent: EventModel? {
    //        savedEvents.first { $0.event_id == self.eventID) }
    //    } REFACTOR - DEFINE EVENTID WITH A FUNCTION
    
//    func selectedEvent(for id: UUID) -> EventModel? {
//        savedEvents.first { $0.event_id == id }
//    }
//
    
    func selectedEvent(for id: UUID) -> EventModel? {
        guard let modelContext else { return nil }
        let descriptor = FetchDescriptor<EventModel>(
            predicate: #Predicate { $0.event_id == id }
        )
        return try? modelContext.fetch(descriptor).first
    }
// checks if event master events saved (for attendees - admins will generate new IDs)
    func isEventSaved(ticketmasterID: String) -> Bool {
        guard let modelContext else { return false }
        let descriptor = FetchDescriptor<EventModel>(
            predicate: #Predicate { $0.ticketMasterID == ticketmasterID }
        )
        return (try? modelContext.fetchCount(descriptor)) ?? 0 > 0
    }
    
    // MARK: Refactor for persistence
    func createEvent(_ event: EventModel) {
        modelContext?.insert(event)
        savedEvents.append(event)
        saveContext()
    }
    
    
    func updateEvent(_ updated: EventModel) {
        if let existing = savedEvents.first(where: { $0.event_id == updated.event_id }) {
            existing.eventName = updated.eventName
            existing.eventDescription = updated.eventDescription
            existing.eventStart = updated.eventStart
            existing.eventEnd = updated.eventEnd
            existing.eventLocation = updated.eventLocation
            existing.ticketPrice = updated.ticketPrice
            existing.latitude = updated.latitude
            existing.longitude = updated.longitude
            saveContext()
        }
    }
    
    func deleteEvent(id: UUID) {
        if let event = savedEvents.first(where: { $0.event_id == id }) {
            modelContext?.delete(event)
        }
        savedEvents.removeAll { $0.event_id == id }
        saveContext()
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



