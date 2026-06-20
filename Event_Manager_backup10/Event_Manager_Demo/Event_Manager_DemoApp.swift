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
        let schema = Schema([
            EventModel.self,
            UserModel.self
        ])
        
        let config = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: false
        )
        
        do {
            return try ModelContainer(for: schema, configurations: [config])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    // MARK: Coordinators
    @StateObject private var eventDataCoordinator: EventDataCoordinator
    //  MARK: No state object as UI changes with Apple signin library
    private let authCoordinator: AuthCoordinator
    
    // MARK: Initialisation of coordinators
    init() {
        let context = sharedModelContainer.mainContext
        
        _eventDataCoordinator = StateObject(
            wrappedValue: EventDataCoordinator(modelContext: context)
        )
        
        authCoordinator = AuthCoordinator(modelContext: context)
    }
    
    var body: some Scene {
        WindowGroup {
            
            // MARK: ViewModels (dependency injection)
            let eventViewModel = EventViewModel(
                coordinator: eventDataCoordinator
            )
            
            let authViewModel = AuthViewModel(
                authCoordinator: authCoordinator
            )
//            ADD AUTH TO CONTENT VIEW
           
                ContentView(
                    viewModel: eventViewModel,
                    authViewModel: authViewModel
                )
                    .environmentObject(eventDataCoordinator)
                    }
                    .modelContainer(sharedModelContainer)
                }
            }
