// MARK: ARRAY LOOP VERSION — displays all previewEvents as cards, no model pattern. Revert to previous commit if you want the single-card or model version.
//
//  EventPreviewCard.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 21/05/2026.
//

import SwiftUI

// USAGE: Reusable card to see event preview and shorten list views

struct EventPreviewCard: View {
    @ObservedObject var viewModel: EventViewModel
    var body: some View {
        VStack(spacing: 0) {
            // MARK: Scrollable event preview list
            ScrollView {
                VStack(spacing: 16) {
                    VStack {
                        // MARK: Insert search bar to search each card and search by data on the preview card
                        TextField("Search events by name or location", text: $viewModel.searchText)
                            .padding(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(.darkGray), lineWidth: 1.5)
                            )
                            .padding(.horizontal)
                            .padding(.bottom, 8)
                    }
                    ForEach(viewModel.filteredPreviewEvents, id: \.event_id) { event in
                        ZStack {
                            // MARK: Card background gradient
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(.yellow.withAlphaComponent(0.1))
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                            VStack(spacing: 20) {
                                // MARK: title
                                Label{
                                    Text("Preview Event")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                } icon: {
                                    Image(systemName: "eye")
                                        .foregroundColor(.blue)
                                }
                                // MARK: event name & location
                                HStack {
                                    Label {
                                        Text(event.eventName)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    } icon: {
                                        Image(systemName: "pencil")
                                            .foregroundColor(.blue)
                                    }
                                    Label {
                                        Text(event.eventLocation)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    } icon: {
                                        Image(systemName: "pin.fill")
                                            .foregroundColor(.blue)
                                    }
                                }
                                .padding(.horizontal)
                                // MARK: start and end dates
                                HStack {
                                    Label {
                                        Text("Start: \(event.eventStart.formatted(date: .abbreviated, time: .omitted))")
                                    } icon: {
                                        Image(systemName: "calendar")
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    Label {
                                        Text("End: \(event.eventEnd.formatted(date: .abbreviated, time: .omitted))")
                                    } icon: {
                                        Image(systemName: "calendar")
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .padding(.horizontal)
                                // MARK: Bottom nav button
                                NavigationLink(destination: EventCard(eventID: event.event_id)) {
                                    Label("More details", systemImage: "arrow.right")
                                }
                                .frame(maxWidth: 500, alignment: .trailing)
                                .padding()
                            }
                        }
                        .cornerRadius(12)
                        .shadow(radius: 2)
                        .padding(.horizontal)
                    }
                    .padding(.vertical)
                }
            }
        }
    }
}
#Preview {
    EventPreviewCard(viewModel: EventViewModel())
}
