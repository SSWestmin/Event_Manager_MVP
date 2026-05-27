//
//  EventViewModel.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 21/05/2026.
//

// REFACTORS FOR PROTOTYPE
// MARK: Stubbed events with postcodes and coordinates

import Foundation
import SwiftData
import Combine

@MainActor
let mockEvents: [EventModel] = [
    EventModel(
        event_id: UUID(),
        user_id: UUID(),
        eventName: "London Tech Meetup",
        eventDescription: "A meetup for London tech enthusiasts.",
        eventStart: Calendar.current.date(bySettingHour: 18, minute: 0, second: 0, of: Date())!,
        eventEnd: Calendar.current.date(bySettingHour: 21, minute: 0, second: 0, of: Date())!,
        eventLocation: "London",
        ticketPrice: 10.0,
        latitude: 51.5045,
        longitude: -0.1501,
        created: Date(),
        changed: Date()
    ),
    EventModel(
        event_id: UUID(),
        user_id: UUID(),
        eventName: "Mayfair Business Brunch",
        eventDescription: "Networking brunch for business professionals.",
        eventStart: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
        eventEnd: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
        eventLocation: "Birmingham",
        ticketPrice: 12.0,
        latitude: 51.5112,
        longitude: -0.1507,
        created: Date(),
        changed: Date()
    ),
    EventModel(
        event_id: UUID(),
        user_id: UUID(),
        eventName: "Green Park Picnic",
        eventDescription: "Outdoor picnic event at Green Park.",
        eventStart: Calendar.current.date(byAdding: .day, value: 2, to: Date())!,
        eventEnd: Calendar.current.date(byAdding: .day, value: 2, to: Date())!,
        eventLocation: "London",
        ticketPrice: 15.0,
        latitude: 51.5057,
        longitude: -0.1426,
        created: Date(),
        changed: Date()
    ),
    EventModel(
        event_id: UUID(),
        user_id: UUID(),
        eventName: "Cambridge Science Festival",
        eventDescription: "A week-long celebration of science and technology in Cambridge.",
        eventStart: Calendar.current.date(byAdding: .day, value: 3, to: Date())!,
        eventEnd: Calendar.current.date(byAdding: .day, value: 10, to: Date())!,
        eventLocation: "Cambridge",
        ticketPrice: 8.0,
        latitude: 52.2053,
        longitude: 0.1218,
        created: Date(),
        changed: Date()
    ),
    EventModel(
        event_id: UUID(),
        user_id: UUID(),
        eventName: "Manchester Food Carnival",
        eventDescription: "Taste the best of Manchester's street food and local cuisine.",
        eventStart: Calendar.current.date(byAdding: .day, value: 5, to: Date())!,
        eventEnd: Calendar.current.date(byAdding: .day, value: 6, to: Date())!,
        eventLocation: "Manchester",
        ticketPrice: 18.0,
        latitude: 53.4808,
        longitude: -2.2426,
        created: Date(),
        changed: Date()
    )
]

// MARK: - ViewModel
@MainActor
final class EventViewModel: ObservableObject {
    // MARK: - Selected Event ID
    @Published var eventID: UUID? = nil

    // MARK: - Search State
    @Published var searchText: String = ""

    // MARK: - Calendar State
    @Published var calendarSelectedDate: Date = Date()

    // MARK: - Auth State
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
    @Published var user_id: UUID = UUID()
    
//    MARK: Empty initialiser
    init() {}

    // MARK: - Preview Filtered Events (Map / UI)
    var filteredEvents: [EventModel] {
        filter(events: mockEvents)
    }

    var filteredPreviewEvents: [EventModel] {
        filter(events: mockEvents)
    }

    // MARK: - Calendar Filter
    var eventsForSelectedDate: [EventModel] {
        mockEvents.filter { event in
            Calendar.current.isDate(calendarSelectedDate, inSameDayAs: event.eventStart) ||
            (calendarSelectedDate > event.eventStart && calendarSelectedDate <= event.eventEnd)
        }
    }

    // MARK: - Core Filter Logic (single source of truth)
    private func filter(events: [EventModel]) -> [EventModel] {
        let search = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

        guard !search.isEmpty else { return events }

        return events.filter {
            $0.eventName.lowercased().contains(search) ||
            $0.eventLocation.lowercased().contains(search)
        }
    }

    // MARK: - Date Formatter
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

    // MARK: - Update Calendar to First Match
    func updateCalendarDateToFirstMatch() {
        let search = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !search.isEmpty else { return }

        if let match = mockEvents.first(where: {
            $0.eventName.localizedCaseInsensitiveContains(search) ||
            $0.eventLocation.localizedCaseInsensitiveContains(search)
        }) {
            calendarSelectedDate = match.eventStart
        }
    }

    // MARK: - CRUD (simple in-memory)

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
