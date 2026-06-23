//
// SavedEventsView.swift
//  Event_Manager_MVP
//
//  Created by Sumi Sastri on 21/05/2026.
//

import SwiftUI
import SwiftData

// USAGE:  Child view to show list of saved events for attendee
// Empty state till data passed from root to rest of the views

struct SavedEventsView: View {
    @ObservedObject var viewModel: EventViewModel
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
        }
    }
}


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
