//
//  EventModel.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 21/05/2026.
//

import Foundation
import SwiftData


// USAGE: Refactor 1 update model for views
// Note: maintain var order
@Model
class EventModel: Identifiable, Equatable {

    // MARK: - Identifiable Support
    @Attribute(.unique) var event_id: UUID = UUID()   // backend / external ID
    var id: UUID { event_id } // SwiftData ID
    var user_id: UUID = UUID()

    var eventName: String
    var eventDescription: String
    var eventStart: Date
    var eventEnd: Date
    var eventLocation: String

    var ticketPrice: Double
    var latitude: Double
    var longitude: Double

    var created: Date
    var changed: Date

    // MARK: - Initialisation
    init(
        event_id: UUID = UUID(),
        user_id: UUID = UUID(),
        eventName: String,
        eventDescription: String,
        eventStart: Date,
        eventEnd: Date,
        eventLocation: String,
        ticketPrice: Double,
        latitude: Double,
        longitude: Double,
        created: Date = Date(),
        changed: Date = Date()
    ) {
        self.event_id = event_id
        self.user_id = user_id
        self.eventName = eventName
        self.eventDescription = eventDescription
        self.eventStart = eventStart
        self.eventEnd = eventEnd
        self.eventLocation = eventLocation
        self.ticketPrice = ticketPrice
        self.latitude = latitude
        self.longitude = longitude
        self.created = created
        self.changed = changed
    }

    // MARK: - Equatable Support
    static func == (lhs: EventModel, rhs: EventModel) -> Bool {
        lhs.event_id == rhs.event_id
    }
}
