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
    @ObservedObject var viewModel: EventViewModel
//    MARK: refactor to invoke coordinator
    @EnvironmentObject var coordinator: EventDataCoordinator
    
    var body: some View {
        Label("Archive Events", systemImage: "document")
            .font(.title)
            .padding()
        VStack{
            if let event = coordinator.savedEvents.first {
                EventCard(event: event, viewModel: viewModel)
                HStack {
                    Text("Keep or delete?")
                    Spacer()
                    Button {
                    } label: {
                        Label("", systemImage: "trash")
                    }
                }
                .padding(.horizontal)
            }
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

    ArchivedEventsView(viewModel: viewModel)
        .environmentObject(coordinator)
        .modelContainer(container)
}
