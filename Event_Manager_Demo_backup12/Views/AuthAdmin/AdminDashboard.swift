//
//  AdminDashboard.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 14/06/2026.
//

import SwiftUI
import SwiftData

struct AdminDashboard: View {
//    MARK: Refactor to fork admin views using admin VM not event VM
    @ObservedObject var viewModel: AdminViewModel
    var body: some View {
        VStack(spacing: 16) {
            Text("Welcome to your dashboard where you can create, update, archive or delete events")
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
let viewModel = AdminViewModel(coordinator: coordinator)

AdminDashboard(viewModel: viewModel)
    .environmentObject(coordinator)
    .modelContainer(container)
}
