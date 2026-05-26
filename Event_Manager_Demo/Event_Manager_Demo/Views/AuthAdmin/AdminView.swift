//
//  AdminView.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 22/05/2026.
//

import SwiftUI

// USAGE: Admin to manage events with CRUD actions
// Note: nav not required auto toggle with nav stack

struct AdminView: View {
    var body: some View {
        NavigationStack {
            VStack {
                // MARK: Top Bar
                HStack {
                    // MARK: Logout Button
                    Button {
                        // Logout action
                    } label: {
                        Label("Logout", systemImage: "person.crop.circle.badge.xmark")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal)
                .padding(.top)

                // MARK: Create Button
                NavigationLink(destination: CreateEventView()) {
                    Label("Create event", systemImage: "pencil")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)

                // MARK: Title
                Text("Manage events")
                    .font(.title)

                // MARK: Reusable Event Preview Card
                VStack {
                    EventPreviewCard()

                    // MARK: Bottom Nav Buttons - Archive & Update Event
                    HStack {
                        NavigationLink(destination: ArchivedEventsView()) {
                            Label("Archive event", systemImage: "arrow.left")
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)

                        NavigationLink(destination: UpdateEventView()) {
                            Label("Update event", systemImage: "arrow.right")
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                .padding(.horizontal)

                Spacer()
            }
        }
    }
}
#Preview {
    AdminView()
}
