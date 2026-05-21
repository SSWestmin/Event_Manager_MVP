//
//  EventModel.swift
//  Event_Manager_MVP
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
    var eventLocation: String
    var ticketPrice: Double
    // API mapping
    //    var created :Date
    //    var changed: Date
    //    var eventStatus
    //    var user_id: UUID = UUID()
    //    eventbriteEventID
    //    var venue_id: UUID = UUID()
    //    eventbriteURL
    //    eventbriteUserID
    //    isPublic
    //    termsAndConditions
    //    refundPolicyText
    
    // MARK: initialisation
    init(
        event_id: UUID,
        eventName: String,
        eventDescription: String,
        eventStart: Date,
        eventEnd: Date,
        eventLocation: String,
        ticketPrice: Double
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
    }
}

