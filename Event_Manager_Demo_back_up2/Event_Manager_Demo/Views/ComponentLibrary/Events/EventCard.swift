//
//  EventCard.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 21/05/2026.
//

import SwiftUI

// USAGE: Reusable card to see event details from a preview
// Note: nav not required auto toggle with nav stack

struct EventCard: View {
    let eventID: UUID

    // Look up the event in the previewEvents array
    var event: EventModel? {
        previewEvents.first { $0.event_id == eventID }
    }

    var body: some View {
        ZStack{
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(.white),
                    Color(.yellow.withAlphaComponent(0.5))
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            VStack(spacing: 20) {
                Text("Event Details")
                    .font(.title)
                if let event = event {
                    HStack {
                        Label {
                            Text(event.eventName)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        } icon: {
                            Image(systemName: "pencil")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.horizontal)
                    HStack {
                        Label {
                            Text(event.eventDescription)
                                .frame(maxWidth: 350, alignment: .leading)
                        } icon: {
                            Image(systemName: "list.bullet")
                                .foregroundColor(.blue)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    HStack {
                        Label {
                            Text("Start: \(event.eventStart.formatted(date: .abbreviated, time: .omitted))")
                        } icon: {
                            Image(systemName: "calendar")
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal)
                    HStack{
                        Label {
                            Text("End: \(event.eventEnd.formatted(date: .abbreviated, time: .omitted))")
                        } icon: {
                            Image(systemName: "calendar")
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal)
                    HStack {
                        Label {
                            Text(event.eventLocation)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        } icon: {
                            Image(systemName: "pin.fill")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.horizontal)
                    HStack {
                        Label {
                            Text(event.ticketPrice, format: .currency(code: "GBP"))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        } icon: {
                            Image(systemName: "ticket")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.horizontal)
                    // If you want to show ticketDetails, add here if present in EventModel
                } else {
                    Text("Event not found.")
                        .foregroundColor(.red)
                }
            }
        } // End of V Stack
    } // End of Z stack
}

#Preview {
    // Use a valid eventID from previewEvents for preview, or fallback
    EventCard(eventID: previewEvents.first?.event_id ?? UUID())
}
