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
    @ObservedObject var viewModel: EventViewModel
    var body: some View {
        Label("Archive Events", systemImage: "document")
            .font(.title)
            .padding()
        VStack{
            EventCard(eventID: UUID(), viewModel: viewModel)
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

// REFACTOR import swift data and change preview

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
