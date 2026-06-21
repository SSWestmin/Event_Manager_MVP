//
//  ArchivedEventsView.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 22/05/2026.
//

import SwiftUI
import SwiftData

// USAGE: Admin to archive and then delete events

struct ArchivedEventsView: View {
    // MARK: State object changes to Observed Object of VM
    @ObservedObject var viewModel: AdminViewModel
    
    var body: some View {
        Label("Archive Events", systemImage: "document")
            .font(.title)
            .padding()
        VStack{
            if let event = viewModel.savedEvents.first {
                EventCard(event: event, viewModel: viewModel)
                HStack {
                    Text("Keep or delete?")
                    Spacer()
                    Button {
                        viewModel.deleteEvent(id: event.event_id)
                    } label: {
                        Label("", systemImage: "trash")
                    }
                }
                .padding(.horizontal)
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
    let viewModel = AdminViewModel(coordinator: coordinator)

    ArchivedEventsView(viewModel: viewModel)
        .modelContainer(container)
}
