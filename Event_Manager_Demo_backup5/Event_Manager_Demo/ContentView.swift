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


struct ContentView: View {
    @StateObject private var eventViewModel = EventViewModel()
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
                EventsListView(viewModel: eventViewModel)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
