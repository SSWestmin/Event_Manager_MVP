// MARK: ARRAY LOOP VERSION — displays all previewEvents as cards, no model pattern. Revert to previous commit if you want the single-card or model version.
//
//  EventPreviewCard.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 21/05/2026.
//

import SwiftUI

// USAGE: Reusable card to see event preview and shorten list views

// MARK: Stubbed events with postcodes and coordinates
let previewEvents: [EventModel] = [
    EventModel(
        event_id: UUID(),
        eventName: "London Tech Meetup",
        eventDescription: "A meetup for London tech enthusiasts.",
        eventStart: Calendar.current.date(bySettingHour: 18, minute: 0, second: 0, of: Date())!,
        eventEnd: Calendar.current.date(bySettingHour: 21, minute: 0, second: 0, of: Date())!,
        eventLocation: "London",
        ticketPrice: 10.0,
        latitude: 51.5045, longitude: -0.1501 // W1J 8PG
    ),
    EventModel(
        event_id: UUID(),
        eventName: "Mayfair Business Brunch",
        eventDescription: "Networking brunch for business professionals.",
        eventStart: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
        eventEnd: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
        eventLocation: "Birmingham",
        ticketPrice: 12.0,
        latitude: 51.5112, longitude: -0.1507 // W1K 2AB
    ),
    EventModel(
        event_id: UUID(),
        eventName: "Green Park Picnic",
        eventDescription: "Outdoor picnic event at Green Park.",
        eventStart: Calendar.current.date(byAdding: .day, value: 2, to: Date())!,
        eventEnd: Calendar.current.date(byAdding: .day, value: 2, to: Date())!,
        eventLocation: "London",
        ticketPrice: 15.0,
        latitude: 51.5057, longitude: -0.1426 // W1J 7AF
    ),
    EventModel(
        event_id: UUID(),
        eventName: "Cambridge Science Festival",
        eventDescription: "A week-long celebration of science and technology in Cambridge.",
        eventStart: Calendar.current.date(byAdding: .day, value: 3, to: Date())!,
        eventEnd: Calendar.current.date(byAdding: .day, value: 10, to: Date())!,
        eventLocation: "Cambridge",
        ticketPrice: 8.0,
        latitude: 52.2053, longitude: 0.1218 // CB2 1TN
    ),
    EventModel(
        event_id: UUID(),
        eventName: "Manchester Food Carnival",
        eventDescription: "Taste the best of Manchester's street food and local cuisine.",
        eventStart: Calendar.current.date(byAdding: .day, value: 5, to: Date())!,
        eventEnd: Calendar.current.date(byAdding: .day, value: 6, to: Date())!,
        eventLocation: "Manchester",
        ticketPrice: 18.0,
        latitude: 53.4808, longitude: -2.2426 // M1 1AE
    )
]


// MARK: List of event previews (no model pattern)
struct EventPreviewCard: View {
    @State private var searchText: String = ""
  var body: some View {
        VStack(spacing: 0) {
        // Filter events based on search text (name or location)
        let filteredEvents = previewEvents.filter { event in
            let search = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
            if search.isEmpty { return true }
            return event.eventName.lowercased().contains(search) || event.eventLocation.lowercased().contains(search)
        }
        ScrollView {
            VStack(spacing: 16) {
                VStack{
                    // MARK: Insert search bar to search each card and search by
                    // data on the preview card
                    TextField("Search events by name or location", text: $searchText)
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(.darkGray), lineWidth: 1.5)
                        )
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                }
                ForEach(filteredEvents, id: \.event_id) { event in
                    ZStack {
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color(.yellow.withAlphaComponent(0.1))
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        
                        VStack(spacing: 20) {
                            // MARK: title
                            Label{
                                Text("Preview Event")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            } icon: {
                                Image(systemName: "eye")
                                    .foregroundColor(.blue)
                            }
                            // MARK: event name & location
                            HStack {
                                Label {
                                    Text(event.eventName)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                } icon: {
                                    Image(systemName: "pencil")
                                        .foregroundColor(.blue)
                                }
                                Label {
                                    Text(event.eventLocation)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                } icon: {
                                    Image(systemName: "pin.fill")
                                        .foregroundColor(.blue)
                                }
                            }
                            .padding(.horizontal)
                            // MARK: start and end dates
                            HStack {
                                Label {
                                    Text("Start: \(event.eventStart.formatted(date: .abbreviated, time: .omitted))")
                                } icon: {
                                    Image(systemName: "calendar")
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                Label {
                                    Text("End: \(event.eventEnd.formatted(date: .abbreviated, time: .omitted))")
                                } icon: {
                                    Image(systemName: "calendar")
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .padding(.horizontal)
                            // MARK: Bottom nav button
                            NavigationLink(destination: EventCard(eventID: event.event_id)) {
                                Label("More details", systemImage: "arrow.right")
                            }
                            .frame(maxWidth: 500, alignment: .trailing)
                            .padding()
                        }
                    }
                    .cornerRadius(12)
                    .shadow(radius: 2)
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
        }
    }
} //  Ends Body view
} // Ends struct
#Preview {
    EventPreviewCard()
}
