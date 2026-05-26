//
//  CreateEventView.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 22/05/2026.
//

import SwiftUI

// USAGE: Admin create new event
// Note: nav not required auto toggle with nav stack

struct CreateEventView: View {
    //     MARK: stubbing with local state vars
    @State private var eventName: String = "Chelsea Flower Show"
    @State private var eventDescription: String = "Annual flower shower held in London organised by the Royal Horticultural Society"
    @State private var eventStart: Date = Date().addingTimeInterval(60*60*24)
    @State private var eventEnd: Date = Date().addingTimeInterval(60*60*24*7)
    @State private var eventLocation: String = "London, UK"
    @State private var ticketPrice: Double = 20.00
    @State private var ticketDetails: String = "Full refund up to one week before event, 50% discount for group bookings"
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(.white),
                    Color(.blue.withAlphaComponent(0.25))
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            VStack(spacing: 20) {
                
                //        MARK: title
                Text("Create New Event")
                    .font(.title)
                
                //        MARK: FORM FIELDS
                HStack {
                    //        MARK: event name
                    Label {
                        TextField("Event name", text: $eventName)
                            .textFieldStyle(.roundedBorder)
                    } icon: {
                        Image(systemName: "pencil")
                            .foregroundColor(.blue)
                    }
                }
                .padding(.horizontal)
                
                //        MARK: event description
                HStack {
                    Label {
                        TextField("Event description", text: $eventDescription, axis: .vertical)
                            .textFieldStyle(.roundedBorder)
                    } icon: {
                        Image(systemName: "list.bullet")
                            .foregroundColor(.blue)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                
                //        MARK: date picker fields
                HStack {
                    Label {
                        DatePicker(
                            "Start",
                            selection: $eventStart,
                            displayedComponents: .date
                        )
                    } icon: {
                        Image(systemName: "calendar")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal)
                
                HStack {
                    Label {
                        DatePicker(
                            "End",
                            selection: $eventEnd,
                            displayedComponents: .date
                        )
                    } icon: {
                        Image(systemName: "calendar")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal)
                
                //              MARK: location
                HStack {
                    Label {
                        TextField("Location", text: $eventLocation)
                            .textFieldStyle(.roundedBorder)
                    } icon: {
                        Image(systemName: "pin.fill")
                            .foregroundColor(.blue)
                    }
                }
                .padding(.horizontal)
                
                //              MARK: ticket price
                HStack {
                    Label {
                        TextField(
                            "Ticket price",
                            value: $ticketPrice,
                            format: .currency(code: "GBP")
                        )
                        .textFieldStyle(.roundedBorder)
                    } icon: {
                        Image(systemName: "ticket")
                            .foregroundColor(.blue)
                    }
                }
                .padding(.horizontal)
                
                //        MARK: ticket refund policy
                HStack {
                    Label {
                        TextField("Ticket details", text: $ticketDetails, axis: .vertical)
                            .textFieldStyle(.roundedBorder)
                    } icon: {
                        Image(systemName: "arrow.2.circlepath.circle")
                            .foregroundColor(.blue)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                //                MARK: Bottom nav add event button
                Button {
                } label: {
                    Label("Add Event", systemImage: "arrow.right")
                }
                .frame(maxWidth: 500, alignment: .trailing)
            }
            
        } // End of V Stack
    } // End of Z stack
}

#Preview {
    CreateEventView()
}
