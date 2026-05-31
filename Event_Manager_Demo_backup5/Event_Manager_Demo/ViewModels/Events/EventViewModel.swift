//
//  EventViewModel.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 21/05/2026.
//


import Foundation
import SwiftData
import Combine


// USAGE: Events SSOT drives events and calendar views and local state updates
// Consider calendar VM to drive calendar for clean separation of concerns and debugging

@MainActor
final class EventViewModel: ObservableObject {
    // MARK: - Selected Event ID
    @Published var eventID: UUID? = nil

    // MARK: - Search State
    @Published var searchText: String = ""

    // MARK: - Calendar State
    @Published var calendarSelectedDate: Date = Date()

    // MARK: - Auth State (who is in the session - check for API data redundancy)
    @Published var user_id: UUID = UUID()
    @Published var currentUserID: UUID?
    @Published var currentUserRole: String?

    // MARK: - Alerts / Navigation
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var navigateToSaved: Bool = false

    // MARK: - Saved Events
    @Published var savedEvents: [EventModel] = []

    // MARK: - Form State
    @Published var eventName: String = ""
    @Published var eventDescription: String = ""
    @Published var eventStart: Date = Date()
    @Published var eventEnd: Date = Date()
    @Published var eventLocation: String = ""
    @Published var ticketPrice: Double = 0.0
    @Published var latitude: Double = 51.5074
    @Published var longitude: Double = -0.1278

    
//    MARK: Empty initialiser
    init() {}

    // MARK: - API-backed Events the event model array populated 
    // by the API and drives the map and calendar views (filtered by search text)

    @Published var events: [EventModel] = []
    @Published var isLoading: Bool = false
    @Published var apiError: String? = nil

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

    // MARK: - Filtered Events (Map / UI)
    var filteredEvents: [EventModel] {
        filter(events: events)
    }

    var filteredPreviewEvents: [EventModel] {
        filter(events: events)
    }

    // MARK: - Calendar Filter
    var eventsForSelectedDate: [EventModel] {
        events.filter { event in
            Calendar.current.isDate(calendarSelectedDate, inSameDayAs: event.eventStart) ||
            (calendarSelectedDate > event.eventStart && calendarSelectedDate <= event.eventEnd)
        }
    }
    
    // MARK: - Update Calendar to First Match
    func updateCalendarDateToFirstMatch() {
        let search = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !search.isEmpty else { return }

        if let match = events.first(where: {
            $0.eventName.localizedCaseInsensitiveContains(search) ||
            $0.eventLocation.localizedCaseInsensitiveContains(search)
        }) {
            calendarSelectedDate = match.eventStart
        }
    }

    // MARK: - Core Filter Logic for all searches by text across views (SSOT)
    private func filter(events: [EventModel]) -> [EventModel] {
        let search = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

        guard !search.isEmpty else { return events }

        return events.filter {
            $0.eventName.lowercased().contains(search) ||
            $0.eventLocation.lowercased().contains(search)
        }
    }

    // MARK: - Date Formatter (should this be in utilities?)
    private let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .medium
        return f
    }()

    func formatted(date: Date) -> String {
        formatter.string(from: date)
    }

    var formattedCalendarDate: String {
        formatted(date: calendarSelectedDate)
    }


    // MARK: - CRUD (simple in-memory - refactor with environment obj/ @query and persitent data)

    var selectedEvent: EventModel? {
        savedEvents.first { $0.event_id == self.eventID }
    }

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
}
