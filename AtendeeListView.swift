//
//  AtendeeListView.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 24/05/2026.
//

import SwiftUI

// USAGE: Attendee to continue as auth user to browse events

struct AtendeeListView: View {
    var body: some View {
            VStack {
                // MARK: Top Bar
                HStack {
                    Spacer()
                    
                    Button {
                        // Logout action
                    } label: {
                        Label("Logout", systemImage: "person.crop.circle.badge.xmark")
                            .font(.headline)
                    }
                }
                .padding(.horizontal)
                .padding(.top)
                
                // MARK: Events List
                EventsListView()
            }
        }
    }

#Preview {
    AtendeeListView()
}
