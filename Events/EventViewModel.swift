//
//  EventViewModel.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 21/05/2026.
//

// REFACTORS FOR PROTOTYPE
// MARK: Stubbed events with postcodes and coordinates

import Foundation

    var event_id: UUID = UUID()
    var eventName: String
    var eventDescription: String
    var eventStart: Date
    var eventEnd: Date
    var eventLocation: String // e.g. postcode or address
    var ticketPrice: Double
    var latitude: Double
    var longitude: Double


let previewEvents: [EventModel] = [
    EventModel(
        event_id: UUID(),
        eventName: "London Tech Meetup",
        eventDescription: "A meetup for London tech enthusiasts.",
        eventStart: Calendar.current.date(bySettingHour: 18, minute: 0, second: 0, of: Date())!,
        eventEnd: Calendar.current.date(bySettingHour: 21, minute: 0, second: 0, of: Date())!,
        eventLocation: "London",
        ticketPrice: 10.0,
        latitude: 51.5045, 
        longitude: -0.1501 // W1J 8PG
    ),
    EventModel(
        event_id: UUID(),
        eventName: "Mayfair Business Brunch",
        eventDescription: "Networking brunch for business professionals.",
        eventStart: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
        eventEnd: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
        eventLocation: "Birmingham",
        ticketPrice: 12.0,
        latitude: 51.5112, 
        longitude: -0.1507 // W1K 2AB
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

@MainActor
class EventViewModel: ObservableObject {
//  MARK REFACTOR: Move all state vars to SSOT - EventViewModel
//  Search text 
    @State private var searchText: String = ""
// Event Card 
    let eventID: UUID
    var event: EventModel? {
        previewEvents.first { $0.event_id == eventID }
    }
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var navigateToSaved = false
    @State private var localSavedEvents: [EventModel] = []
//  Event List view
    @State private var savedEvents: [EventModel] = []
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var navigateToSaved = false

    // Create event view
     @State private var eventName: String = "Chelsea Flower Show"
    @State private var eventDescription: String = "Annual flower shower held in London organised by the Royal Horticultural Society"
    @State private var eventStart: Date = Date().addingTimeInterval(60*60*24)
    @State private var eventEnd: Date = Date().addingTimeInterval(60*60*24*7)
    @State private var eventLocation: String = "London, UK"
    @State private var ticketPrice: Double = 20.00
    @State private var ticketDetails: String = "Full refund up to one week before event, 50% discount for group bookings"

// Update event by id
    @State private var eventName: String = "Chelsea Flower Show"
    @State private var eventDescription: String = "Annual flower shower held in London organised by the Royal Horticultural Society"
    @State private var eventStart: Date = Date().addingTimeInterval(60*60*24)
    @State private var eventEnd: Date = Date().addingTimeInterval(60*60*24*7)
    @State private var eventLocation: String = "London, UK"
    @State private var ticketPrice: Double = 20.00
    @State private var ticketDetails: String = "Full refund up to one week before event, 50% discount for group bookings"
	}
}
