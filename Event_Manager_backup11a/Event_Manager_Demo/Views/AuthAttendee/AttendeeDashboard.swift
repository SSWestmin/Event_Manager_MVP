//
//  AttendeeDashboard.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 20/06/2026.
//

import SwiftUI
import SwiftData

struct AttendeeDashboard: View {
// MARK: Maintain eventVM for attendee till EventKit refactor
    @ObservedObject var viewModel: EventViewModel

    var body: some View {
        VStack(spacing: 16) {
            Text("Welcome to your dashboard where you can save your favorite events")
                .font(.headline)

            EventsListView(viewModel: viewModel)
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

    AttendeeDashboard(viewModel: viewModel)
        .environmentObject(coordinator)
        .modelContainer(container)
}
