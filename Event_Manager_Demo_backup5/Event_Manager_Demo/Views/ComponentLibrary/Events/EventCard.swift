//
//  EventCard.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 21/05/2026.
//

import SwiftUI

// USAGE: Reusable card to see event details from a preview
// Note: nav not required auto toggle with nav stack
// conditionally renders card to admin or attendee based on role

//TO DO: REFACTOR TO MOVE DATA TO AUTH OR USERS VM WITH AUTH WIRED UP

struct EventCard: View {
    let eventID: UUID
    @ObservedObject var viewModel: EventViewModel
    let userRole: String = "attendee" // Change to "admin" to test admin view
    var event: EventModel? {
        viewModel.events.first { $0.event_id == eventID }
    }
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var navigateToSaved = false
    @State private var localSavedEvents: [EventModel] = []

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(.white),
                        Color(.yellow.withAlphaComponent(0.5))
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                VStack(spacing: 20) {
                    // MARK: Conditional render Admin, logout, title and create event
                    if userRole == "admin" {
                        HStack {
                            Button {
                                // MARK: logout
                            } label: {
                                Label("Logout", systemImage: "person.crop.circle.badge.xmark")
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        Text("Manage events")
                            .font(.title)
                        NavigationLink(destination: CreateEventView()) {
                            Label("Create event", systemImage: "pencil")
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    // MARK: Conditional render Attendee, logout, title
                    } else if userRole == "attendee" {
                        HStack {
                            Text("My Events")
                                .font(.title)
                            Button {
                                // MARK: logout
                            } label: {
                                Label("Logout", systemImage: "person.crop.circle.badge.xmark")
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                    // MARK: Event details
                    Text("Event Details")
                        .font(.title)
                    if let event = event {
                        HStack {
                            // MARK: Event name
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
                            // MARK: Event description
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
                            // MARK: Event start date
                            Label {
                                Text("Start: \(event.eventStart.formatted(date: .abbreviated, time: .omitted))")
                            } icon: {
                                Image(systemName: "calendar")
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding(.horizontal)
                        HStack{
                            // MARK: Event end date
                            Label {
                                Text("End: \(event.eventEnd.formatted(date: .abbreviated, time: .omitted))")
                            } icon: {
                                Image(systemName: "calendar")
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding(.horizontal)
                        HStack {
                            // MARK: Event location
                            Label {
                                Text(event.eventLocation)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            } icon: {
                                Image(systemName: "pin.fill")
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.horizontal)
                        // MARK: Event price (note only for prototype
                        // To be refactored with ticket model and purchase flow)
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
                    } else {
                        Text("Event not found.")
                            .foregroundColor(.red)
                    }
                    // MARK: Conditional render admin - actions update, archive
                    if userRole == "admin" {
                        HStack {
                            HStack {
                                NavigationLink(destination: ArchivedEventsView(viewModel: viewModel)) {
                                    Label("Archive event", systemImage: "arrow.left")
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                NavigationLink(destination: UpdateEventView(viewModel: viewModel)) {
                                    Label("Update event", systemImage: "arrow.right")
                                }
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            .padding(.horizontal)
                        }
                    // MARK: Conditional render attendee - save to list
                    } else if userRole == "attendee" {
                        Button {
                            if let event = event {
                                if localSavedEvents.contains(where: { $0.event_id == event.event_id }) {
                                    alertMessage = "Your event has already been saved."
                                    showAlert = true
                                } else {
                                    localSavedEvents.append(event)
                                    alertMessage = "Your event has been saved: \(event.eventName)"
                                    showAlert = true
                                }
                            }
                        } label: {
                            Label("Save to faves", systemImage: "heart.fill")
                        }
                        .navigationDestination(isPresented: $navigateToSaved) {
                            SavedEventsView(
                                savedEvents: localSavedEvents,
                                viewModel: viewModel
                            )
                        }
                    }
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Saved Events"),
                        message: Text(alertMessage),
                        dismissButton: .default(Text("OK")) {
                            if alertMessage.starts(with: "Your event has been saved") {
                                navigateToSaved = true
                            }
                        }
                    )
                }
            }
        }
    }
}

#Preview {
    // For preview, create a VM and load sample data if needed
    let vm = EventViewModel()
    return EventCard(eventID: UUID(), viewModel: vm)
}
