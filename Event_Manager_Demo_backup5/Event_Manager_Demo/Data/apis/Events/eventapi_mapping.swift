// eventapi_mapping.swift
// Created: 31/05/2026, Renamed: 31/05/2026



import Foundation
import SwiftData

// USAGE: Mapping extension to convert TicketmasterEvent DTO to EventModel objects
// (SwiftData)

extension EventModel {
    convenience init?(from ticketmasterEvent: TicketmasterEvent) {
        guard let _ = ticketmasterEvent.id,
              let name = ticketmasterEvent.name,
              let startDateString = ticketmasterEvent.dates?.start?.dateTime,
              let startDate = ISO8601DateFormatter().date(from: startDateString)
        else {
            return nil // Required fields missing
        }
// Ticketmaster API may not provide end date; use start as fallback
        let eventDescription = ticketmasterEvent.info ?? "No details provided by the event organiser."
        let endDate = startDate 

        let venue = ticketmasterEvent.embedded?.venues?.first
        let addressParts = [
            venue?.address?.line1,
            venue?.city?.name,
            venue?.state?.name,
            venue?.country?.name,
            venue?.postalCode
        ].compactMap { $0 }
        let eventLocation = addressParts.joined(separator: ", ")

        let latitude = Double(venue?.location?.latitude ?? "0.0") ?? 0.0
        let longitude = Double(venue?.location?.longitude ?? "0.0") ?? 0.0

        let ticketPrice: Double = 0.0 // Add price extraction if DTO is extended

        self.init(
            event_id: UUID(),
            eventName: name,
            eventDescription: eventDescription,
            eventStart: startDate,
            eventEnd: endDate,
            eventLocation: eventLocation,
            ticketPrice: ticketPrice,
            latitude: latitude,
            longitude: longitude
        )
    }
}
