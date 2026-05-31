//
//  UpdateEventView.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 22/05/2026.
//

import SwiftUI

// USAGE: Admin update existing event
// Note: nav not required auto toggle with nav stack
// Full address with API in refactor

struct UpdateEventView: View {
    @ObservedObject var viewModel: EventViewModel
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
                    guard let existing = viewModel.selectedEvent else { return }
                    
                    let updatedEvent = EventModel(
                        event_id: UUID(),
                        user_id: viewModel.currentUserID ?? existing.user_id,
                        eventName: viewModel.eventName,
                        eventDescription: viewModel.eventDescription,
                        eventStart: viewModel.eventStart,
                        eventEnd: viewModel.eventEnd,
                        eventLocation: viewModel.eventLocation,
                        ticketPrice: viewModel.ticketPrice,
                        latitude: viewModel.latitude,
                        longitude: viewModel.longitude,
                    )
                    viewModel.updateEvent(updatedEvent)
                    // MARK: - TO DO - ADD SUCCESS AND FAIL STATES
                } label: {
                    Label("Update", systemImage: "arrow.right")
                }
                .frame(maxWidth: 500, alignment: .trailing)
            }
        } // End of V Stack
    } // End of Z stack
}
#Preview {
    UpdateEventView(viewModel: EventViewModel())
}
