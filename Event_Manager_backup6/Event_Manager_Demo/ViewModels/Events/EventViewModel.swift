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


class EventViewModel: ObservableObject {
    private let coordinator: EventDataCoordinator
    
    init(coordinator: EventDataCoordinator) {
        self.coordinator = coordinator
    }
    
    // MARK: - Auth State (who is in the session - check for API data redundancy)
    @Published var user_id: UUID = UUID()
    @Published var currentUserID: UUID?
    @Published var currentUserRole: String?
    
    // MARK: - Selected Event ID
    @Published var eventID: UUID? = nil
    
    // MARK: - Search State
    @Published var searchText: String = ""
    
    // MARK: - Calendar State
    @Published var calendarSelectedDate: Date = Date()
    
    
    //    // MARK: - Saved Events
    //    @Published var savedEvents: [EventModel] = []
    
    // MARK: - Form State CHECK FOR CLASHES WITH NON-FORM STATES
    @Published var eventName: String = ""
    @Published var eventDescription: String = ""
    @Published var eventStart: Date = Date()
    @Published var eventEnd: Date = Date()
    @Published var eventLocation: String = ""
    @Published var ticketPrice: Double = 0.0
    @Published var latitude: Double = 51.5074
    @Published var longitude: Double = -0.1278
    
    
    // MARK: - Alerts / Navigation
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var navigateToSaved: Bool = false
    

    // MARK: - Filtered Events (Map / UI) references coordinator
    func selectedEvent(for id: UUID) -> EventModel? {
        coordinator.selectedEvent(for: id)
    }

    var filteredEvents: [EventModel] {
        filter(events: coordinator.events)
    }
    
    var filteredPreviewEvents: [EventModel] {
        filter(events: coordinator.events)
    }
    
    // MARK: - Calendar Filter - refactor to add co-ordinator
    var eventsForSelectedDate: [EventModel] {
        coordinator.events.filter { event in
            Calendar.current.isDate(calendarSelectedDate, inSameDayAs: event.eventStart) ||
            (calendarSelectedDate > event.eventStart && calendarSelectedDate <= event.eventEnd)
        }
    }
    
    // MARK: - Update Calendar to First Match - refactor add co-ordinator
    func updateCalendarDateToFirstMatch() {
        let search = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !search.isEmpty else { return }
        
        if let match = coordinator.events.first(where: {
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
}
