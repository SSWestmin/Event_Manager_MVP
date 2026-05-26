//
//  ContentView.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 21/05/2026.
//

import SwiftUI

struct ContentView: View {
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
                
                EventsListView()
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
