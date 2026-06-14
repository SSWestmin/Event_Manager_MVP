//
//  UpdateEventView.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 22/05/2026.
//

import SwiftUI
import SwiftData

// USAGE: Admin update existing event

struct UpdateEventView: View {
    // MARK: State object changes to Observed Object
    @ObservedObject var viewModel: EventViewModel
    // MARK: Env obj required to access CRUD functions
    @EnvironmentObject var coordinator: EventDataCoordinator
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(.white),
                    Color(.blue.withAlphaComponent(0.1))
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                //        MARK: title
                Text("Update Event")
                    .font(.title)
                    .padding()
                
                //            MARK: FORM FIELDS
                HStack {
                    //        MARK: event name
                    Label {
                        TextField("Event name", text: $viewModel.eventName)
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
                        TextField("Event description", text: $viewModel.eventDescription, axis: .vertical)
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
                            selection: $viewModel.eventStart,
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
                            selection: $viewModel.eventEnd,
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
                        TextField("Location", text: $viewModel.eventLocation)
                            .textFieldStyle(.roundedBorder)
                    } icon: {
                        Image(systemName: "pin.fill")
                            .foregroundColor(.blue)
                    }
                }
                .padding(.horizontal)
                // //              MARK: ticket price no ticket in VM or models
                // HStack {
                //     Label {
                //         TextField(
                //             "Ticket price",
                //             value: $viewModel.ticketPrice,
                //             format: .currency(code: "GBP")
                //         )
                //         .textFieldStyle(.roundedBorder)
                //     } icon: {
                //         Image(systemName: "ticket")
                //             .foregroundColor(.blue)
                //     }
                // }
                // .padding(.horizontal)
                //        MARK: latitude
                HStack {
                    Label {
                        TextField("Latitude", value: $viewModel.latitude, format: .number)
                            .textFieldStyle(.roundedBorder)
                    } icon: {
                        Image(systemName: "location.north.line")
                            .foregroundColor(.blue)
                    }
                }
                .padding(.horizontal)
                //        MARK: longitude
                HStack {
                    Label {
                        TextField("Longitude", value: $viewModel.longitude, format: .number)
                            .textFieldStyle(.roundedBorder)
                    } icon: {
                        Image(systemName: "location.north.line.fill")
                            .foregroundColor(.blue)
                    }
                }
                .padding(.horizontal)
                //                MARK: ticket refund policy - not in VM or model
                //                 HStack {
                //                     Label {
                //                         TextField("Ticket details", text: $viewModel.ticketDetails, axis: .vertical)
                //                             .textFieldStyle(.roundedBorder)
                //                     } icon: {
                //                         Image(systemName: "arrow.2.circlepath.circle")
                //                             .foregroundColor(.blue)
                //                     }
                //                 }
                //                 .frame(maxWidth: .infinity, alignment: .leading)
                //                 .padding(.horizontal)
                //                MARK: Bottom update button with ID of selected event
                
                Button {
//                    MARK: refactor to invoke coordinator and pass the ID
                    guard let id = viewModel.eventID,
                          let existing = coordinator.selectedEvent(for: id) else { return }
                    
                    let updatedEvent = EventModel(
//                        prevent generating a new ID keep existing ID
                        event_id: existing.event_id,
                        user_id: viewModel.currentUserID ?? viewModel.user_id,
                        eventName: viewModel.eventName,
                        eventDescription: viewModel.eventDescription,
                        eventStart: viewModel.eventStart,
                        eventEnd: viewModel.eventEnd,
                        eventLocation: viewModel.eventLocation,
                        ticketPrice: viewModel.ticketPrice,
                        latitude: viewModel.latitude,
                        longitude: viewModel.longitude,
                    )
//                    MARK: refactor to invoke coordinator for CRUD
                    coordinator.updateEvent(updatedEvent)
                    // MARK: - TO DO - ADD SUCCESS AND FAIL STATES
                } label: {
                    Label("Update", systemImage: "arrow.right")
                }
                .frame(maxWidth: 500, alignment: .trailing)
            }
        } // End of V Stack
    } // End of Z stack
}

// REFACTOR import swift data and change preview

#Preview {
    let container = try! ModelContainer(
        for: EventModel.self,
        configurations: .init(isStoredInMemoryOnly: true)
    )
    let coordinator = EventDataCoordinator(modelContext: container.mainContext)
    let viewModel = EventViewModel(coordinator: coordinator)

    UpdateEventView(viewModel: viewModel)
        .environmentObject(coordinator)
        .modelContainer(container)
}
