//
//  Event_Manager_DemoApp.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 21/05/2026.
//

import SwiftUI
import SwiftData

// ROOT FILE - creates the model container and
// injects it into the environment for app-wide access
// Model container data flows uni-directionally top-down to views

@main
struct Event_Manager_DemoApp: App {
    var sharedModelContainer: ModelContainer = {
        // MARK: Schemas to enforce data contracts
        let schema = Schema([
            EventModel.self,
        // add further models here
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    // MARK: Coordinators for data persistence across app
    @StateObject private var eventDataCoordinator: EventDataCoordinator
    // add coordinators here
    //  MARK: Initialiser for model context and the data container
    //  wraps the state object with the model context for data access
    init() {
        let context = sharedModelContainer.mainContext
        _eventDataCoordinator = StateObject(wrappedValue: EventDataCoordinator(modelContext: context))
    // add other model contexts here for persistence across the app
    }
    // MARK: Pass data to views with @EnvironmentObject
    //  Environments passes controller functions to views and take dependencies in params
    //   ModelContainer provides access to data across views and view models
    var body: some Scene {
        WindowGroup {
                let viewModel = EventViewModel(coordinator: eventDataCoordinator)
                ContentView(viewModel: viewModel)
                    .environmentObject(eventDataCoordinator)
            }
            .modelContainer(sharedModelContainer)
        }
}




