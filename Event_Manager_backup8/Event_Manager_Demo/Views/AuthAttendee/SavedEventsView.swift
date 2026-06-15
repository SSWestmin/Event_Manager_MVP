//
// SavedEventsView.swift
//  Event_Manager_MVP
//
//  Created by Sumi Sastri on 21/05/2026.
//


import SwiftUI
import SwiftData

struct SavedEventsView: View {
    // MARK: State object changes to Observed Object of VM
    @ObservedObject var viewModel: EventViewModel
    // Child view to show list of saved events for attendee
    // Empty state till data passed from root to rest of the views
    //    MARK: Refactor use @Query to access data for view
    @Query(sort: \EventModel.eventStart) var savedEvents: [EventModel]
    var body: some View {
        NavigationStack {
            VStack {
                Label("Saved Events", systemImage: "heart.fill")
                    .font(.title)
                if savedEvents.isEmpty {
                    Text("No saved events yet.")
                        .foregroundColor(.gray)
                } else {
                    List(savedEvents, id: \.event_id) { event in
                        NavigationLink(value: event) {
                            Text(event.eventName)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            //          MARK:  disable the forward button default navigation
            //             .navigationDestination(for: EventModel.self) { event in
            // //                EventCard(eventID: event.event_id, viewModel: viewModel)
            //             }
        }
    }
}

//  MARK: Refactor, pass data (coordinator and VM into Content views to preview + import SwiftData
#Preview {
    let container = try! ModelContainer(
        for: EventModel.self,
        configurations: .init(isStoredInMemoryOnly: true)
    )
    let coordinator = EventDataCoordinator(modelContext: container.mainContext)
    let viewModel = EventViewModel(coordinator: coordinator)
    
    SavedEventsView(viewModel: viewModel)
        .environmentObject(coordinator)
        .modelContainer(container)
}
