//
//  CreateEventView.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 22/05/2026.
//

import SwiftUI
import SwiftData

// USAGE: Admin create new event for admin users only

struct CreateEventView: View {
    // MARK: State object changes to Observed Object of VM
    @ObservedObject var viewModel: EventViewModel
    // MARK: Env obj required to access CRUD functions
    @EnvironmentObject var coordinator: EventDataCoordinator
    
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
                //              MARK: location - computed value
                
                HStack {
                    Label {
//                        MARK: refactor composed location
                        Text(viewModel.composedLocation.isEmpty ? "Address will appear here" : viewModel.composedLocation)
                            .foregroundColor(viewModel.eventLocation.isEmpty ? .gray : .primary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    } icon: {
                        Image(systemName: "pin.fill")
                            .foregroundColor(.blue)
                    }
                }
                .padding(.horizontal)
                //                MARK: Refactor to concat location based on TicketMaster API data
                VStack {
                    Label {
                        TextField("Address line 1", text: $viewModel.addressLine1)
                            .textFieldStyle(.roundedBorder)
                    } icon: {
                        Image(systemName: "")
                            .foregroundColor(.blue)
                    }
                   
                    Label {
                        TextField("City", text: $viewModel.city)
                            .textFieldStyle(.roundedBorder)
                    } icon: {
                        Image(systemName: "")
                            .foregroundColor(.blue)
                    }
                    Label {
                        TextField("Country", text: $viewModel.country)
                            .textFieldStyle(.roundedBorder)
                    } icon: {
                        Image(systemName: "")
                            .foregroundColor(.blue)
                    }
                    Label {
                        TextField("Postal code", text: $viewModel.postalCode)
                            .textFieldStyle(.roundedBorder)
                    } icon: {
                        Image(systemName: "")
                            .foregroundColor(.blue)
                    }
                }
                .padding(.horizontal)
                
                // //              MARK: ticket price - not in VM or model - ticket model required
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
//                //        MARK: latitude
//                HStack {
//                    Label {
//                        TextField("Latitude", value: $viewModel.latitude, format: .number)
//                            .textFieldStyle(.roundedBorder)
//                    } icon: {
//                        Image(systemName: "location.north.line")
//                            .foregroundColor(.blue)
//                    }
//                }
//                .padding(.horizontal)
//                //        MARK: longitude
//                HStack {
//                    Label {
//                        TextField("Longitude", value: $viewModel.longitude, format: .number)
//                            .textFieldStyle(.roundedBorder)
//                    } icon: {
//                        Image(systemName: "location.north.line.fill")
//                            .foregroundColor(.blue)
//                    }
//                }
                .padding(.horizontal)
//                //        MARK: ticket refund policy not in model or VM
//                HStack {
//                    Label {
//                        TextField("Ticket details", text: $viewModel.ticketDetails, axis: .vertical)
//                            .textFieldStyle(.roundedBorder)
//                    } icon: {
//                        Image(systemName: "arrow.2.circlepath.circle")
//                            .foregroundColor(.blue)
//                    }
//                }
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding(.horizontal)
                //                MARK: Bottom nav add event button
                Button {
//                    MARK: Refactor of location to match TicketMaster data structure
                    let eventLocation = [
                        viewModel.addressLine1,
                        viewModel.city,
                        viewModel.country,
                        viewModel.postalCode
                    ].filter { !$0.isEmpty }.joined(separator: ", ")
                    let newEvent = EventModel(
                        event_id: UUID(),
                        user_id: viewModel.currentUserID ?? viewModel.user_id,
                        eventName: viewModel.eventName,
                        eventDescription: viewModel.eventDescription,
                        eventStart: viewModel.eventStart,
                        eventEnd: viewModel.eventEnd,
//                        bind location to the filtered and joined version
                        eventLocation: eventLocation,
                        ticketPrice: viewModel.ticketPrice,
                        latitude: viewModel.latitude,
                        longitude: viewModel.longitude,
                    )
//                    no longer vm but coordinator
                    coordinator.createEvent(newEvent)
                    // MARK: - TO DO - ADD SUCCESS AND FAIL STATES
                } label: {
                    Label("Add Event", systemImage: "arrow.right")
                }
                .frame(maxWidth: 500, alignment: .trailing)
            }
            
        } // End of V Stack
    } // End of Z stack
}


//  MARK: Refactor, pass data (coordinator and VM into Content views to preview + import SwiftData
#Preview {
    let container = try! ModelContainer(
        for: EventModel.self,
        configurations: .init(isStoredInMemoryOnly: true)
    )
    let coordinator = EventDataCoordinator(modelContext: container.mainContext)
    let viewModel = EventViewModel(coordinator: coordinator)

    CreateEventView(viewModel: viewModel)
        .environmentObject(coordinator)
        .modelContainer(container)
}

