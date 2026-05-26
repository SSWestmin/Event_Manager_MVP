//
//  EventModel.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 21/05/2026.
//

import Foundation
import SwiftData

// USAGE: Event data pre-API call
// Note: maintain var order
@Model
final class EventModel {
    var event_id: UUID = UUID()
    var eventName: String
    var eventDescription: String
    var eventStart: Date
    var eventEnd: Date
    var eventLocation: String // e.g. postcode or address
    var ticketPrice: Double
    var latitude: Double
    var longitude: Double

    // MARK: initialisation
    init(
        event_id: UUID,
        eventName: String,
        eventDescription: String,
        eventStart: Date,
        eventEnd: Date,
        eventLocation: String,
        ticketPrice: Double,
        latitude: Double,
        longitude: Double
    )
    //MARK: Bindings
    {
        self.event_id = UUID()
        self.eventName = eventName
        self.eventDescription = eventDescription
        self.eventStart = eventStart
        self.eventEnd = eventEnd
        self.eventLocation = eventLocation
        self.ticketPrice = ticketPrice
        self.latitude = latitude
        self.longitude = longitude
    }
}
