//
//  ContentView.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 21/05/2026.
//


// USAGE: Public views to browse - with search view
// Provides nav to auth, map, calendar searches and details of events
//  COMMAND K (CLEAR CONSOLE)/ COMMAND+ SHIFT + K CLEAN BUILD

import SwiftUI
import SwiftData


struct ContentView: View {
//MARK: Refactor to use environment object
    // MARK: State object changes to Observed Object
    @ObservedObject var viewModel: EventViewModel
    // MARK: Env obj required to access fetch (READ) CRUD
    @EnvironmentObject var coordinator: EventDataCoordinator
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Welcome to Event Rabbit")
                Spacer()
                HStack {
                    Spacer()
                    NavigationLink(destination: LoginView()) {
                        Label("Login", systemImage: "person.crop.circle")
                            .foregroundColor(.blue)
                            .underline()
                    }
                }
                Spacer()
//                just vm not event VM
                EventsListView(viewModel: viewModel)
            }
            .padding()
        }
    }
}

//  MARK: Pass data to preview

#Preview {
    let container = try! ModelContainer(
        for: EventModel.self,
        configurations: .init(isStoredInMemoryOnly: true)
    )
    let coordinator = EventDataCoordinator(modelContext: container.mainContext)
    let viewModel = EventViewModel(coordinator: coordinator)

    ContentView(viewModel: viewModel)
        .environmentObject(coordinator)
        .modelContainer(container)
}

