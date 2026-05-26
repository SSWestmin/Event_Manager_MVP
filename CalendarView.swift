//
//  CalendarView.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 26/05/2026.
//


import SwiftUI


import EventKit
import Foundation
import SwiftData

// USAGE: Stubbing events to create events view

// MARK: Stubbed events with all details (same as MapView)
let events: [EventModel] = [
    EventModel(
        event_id: UUID(),
        eventName: "London Tech Meetup",
        eventDescription: "A meetup for London tech enthusiasts.",
        eventStart: Calendar.current.date(bySettingHour: 18, minute: 0, second: 0, of: Date())!,
        eventEnd: Calendar.current.date(bySettingHour: 21, minute: 0, second: 0, of: Date())!,
        eventLocation: "W1J 8PG",
        ticketPrice: 10.0,
        latitude: 51.5045, longitude: -0.1501
    ),
    EventModel(
        event_id: UUID(),
        eventName: "Mayfair Business Brunch",
        eventDescription: "Networking brunch for business professionals.",
        eventStart: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
        eventEnd: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
        eventLocation: "W1K 2AB",
        ticketPrice: 12.0,
        latitude: 51.5112, longitude: -0.1507
    ),
    EventModel(
        event_id: UUID(),
        eventName: "Green Park Picnic",
        eventDescription: "Outdoor picnic event at Green Park.",
        eventStart: Calendar.current.date(byAdding: .day, value: 2, to: Date())!,
        eventEnd: Calendar.current.date(byAdding: .day, value: 2, to: Date())!,
        eventLocation: "W1J 7AF",
        ticketPrice: 15.0,
        latitude: 51.5057, longitude: -0.1426
    )
]

struct CalendarView: View {
    @State private var selectedDate = Date()
    
    var body: some View {
        VStack {
            DatePicker(
                "Select Date",
                selection: $selectedDate,
                displayedComponents: [.date]
            )
            .datePickerStyle(.graphical)
            .padding()
            
            Text("Events on \(formatted(date: selectedDate)):")
                .font(.headline)
                .padding(.top)
// MARK: Show events for the selected date or a message if there are none
            if eventsForSelectedDate.isEmpty {
                Text("No events scheduled today")
                    .foregroundColor(.secondary)
                    .padding()
            } else {
                List(eventsForSelectedDate, id: \.event_id) { event in
                    VStack(alignment: .leading) {
                        Text("\(event.eventName) (\(event.eventLocation))")
                            .font(.body)
                        Text(event.eventDescription)
                            .font(.subheadline)
                        Text("£\(String(format: "%.2f", event.ticketPrice))")
                            .font(.caption)
                        Text("\(formatted(date: event.eventStart)) - \(formatted(date: event.eventEnd))")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
    }
    
    // MARK: Helper functions to filter events for the selected date
    var eventsForSelectedDate: [EventModel] {
        events.filter { event in
            Calendar.current.isDate(selectedDate, inSameDayAs: event.eventStart) ||
            (selectedDate > event.eventStart && selectedDate <= event.eventEnd)
        }
    }
    
    func formatted(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
