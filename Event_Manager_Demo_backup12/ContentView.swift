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
    // MARK: Observed objects for app
    @ObservedObject var viewModel: EventViewModel
    
    // MARK: Env obj required to access fetch (READ) CRUD
    @EnvironmentObject var coordinator: EventDataCoordinator
    
    // MARK: Auth ViewModel (Apple Sign In flow add adminVM for CRUD ops)
    let authViewModel: AuthViewModel
    let adminViewModel: AdminViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Welcome to Event Rabbit")
                    Spacer()
                    Spacer()
                    NavigationLink(destination: LoginView(viewModel: authViewModel, eventViewModel: viewModel, adminViewModel: adminViewModel)) {
                        Label("Login", systemImage: "person.crop.circle")
                            .foregroundColor(.blue)
                            .underline()
                    }
                }
                Spacer()
                EventsListView(viewModel: viewModel)
            }
            .padding()
        }
        }
}

//  MARK: Refactor, pass data (coordinators and VMs into Content views to preview + import SwiftData)

#Preview {
    //    MARK: Container config
    let container = try! ModelContainer(
        for: EventModel.self,
        configurations: .init(isStoredInMemoryOnly: true)
    )
    //   MARK: Rename - 2 coordinators
    let eventCoordinator = EventDataCoordinator(
        modelContext: container.mainContext
    )
    
    let authCoordinator = AuthCoordinator(
        modelContext: container.mainContext
    )
    //   MARK: Rename - 3 VMS
    let eventVM = EventViewModel(coordinator: eventCoordinator)
    let adminVM = AdminViewModel(coordinator: eventCoordinator)
    let authVM = AuthViewModel(authCoordinator: authCoordinator)
    
    ContentView(
        viewModel: eventVM,
        authViewModel: authVM,
        adminViewModel: adminVM
    )
    .environmentObject(eventCoordinator)
    .modelContainer(container)
}

