//
//  EventsListView.swift
//  Event_Manager_MVP
//
//  Created by Sumi Sastri on 21/05/2026.
//

import SwiftUI
import SwiftData

// USAGE: List view navs to map and calendar view with search bar
// Nav stack provides immediate nav back to this view


struct EventsListView: View {
    // MARK: State object changes to Observed Object of VM
    @ObservedObject var viewModel: EventViewModel
    // MARK: Env obj required to access fetch (READ) CRUD
    @EnvironmentObject var coordinator: EventDataCoordinator
    //    MARK: Refactor use @Query to access data for view
    @Query(sort: \EventModel.eventStart) var events: [EventModel]
    
    var body: some View {
        NavigationStack {
            Text("Browse Events")
                .font(.title)
            HStack{
                NavigationLink(destination: MapView(eventVM: viewModel)) {
                    Label("Map View", systemImage: "arrow.left")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
//                 Refactor get data from VM
                NavigationLink(destination: CalendarView(viewModel: viewModel)) {
                    Label("Calendar View", systemImage: "arrow.right")
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            
            EventPreviewCard(
                events: viewModel.filteredEvents,
                viewModel: viewModel
            )
            
        }
        .task {
            await coordinator.fetchEventsFromAPI()
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

    EventsListView(viewModel: viewModel)
        .environmentObject(coordinator)
        .modelContainer(container)
}

