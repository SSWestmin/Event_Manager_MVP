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

@main
struct Event_Manager_DemoApp: App {
//    MARK: schemas in model container
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
            
            // MARK: ViewModels (coordinator dependency injection)
            let eventViewModel = EventViewModel(
                coordinator: eventDataCoordinator
            )
            
            let authViewModel = AuthViewModel(
                authCoordinator: authCoordinator
            )
            
            let adminViewModel = AdminViewModel(
                coordinator: eventDataCoordinator
            )
// MARK: pass VMs to content view
                ContentView(
                    viewModel: eventViewModel,
                    authViewModel: authViewModel,
                    adminViewModel: adminViewModel,
                )
                    .environmentObject(eventDataCoordinator)
                    }
                    .modelContainer(sharedModelContainer)
                }
            }
