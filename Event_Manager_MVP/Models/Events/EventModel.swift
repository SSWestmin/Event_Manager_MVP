//
//  EventModel.swift
//  Event_Manager_MVP
//
//  Created by Sumi Sastri on 21/05/2026.
//

import Foundation
import SwiftData

// USAGE: Defines data structure
// Note: maintain var order
@Model
final class EventModel {
    var event_id: UUID = UUID()
    var venue_id: UUID = UUID()
    var name: String
    var eventDescription: String
    var start: Date
    var end: Date
    // API mapping
    //    var created :Date
    //    var changed: Date
    //    var eventStatus
    //    var user_id: UUID = UUID()
    //    eventbriteEventID
    //    eventbriteURL
    //    eventbriteUserID
    //    isPublic
    //    termsAndConditions
    //    refundPolicyText
    
    // MARK: initialisation
    init(
        event_id: UUID,
        venue_id: UUID,
        name: String,
        eventDescription: String,
        start: Date,
        end: Date,
    )
    //MARK: Bindings
    {
        self.event_id = UUID()
        self.venue_id = UUID()
        self.name = name
        self.eventDescription = eventDescription
        self.start = start
        self.end = end
    }
}
