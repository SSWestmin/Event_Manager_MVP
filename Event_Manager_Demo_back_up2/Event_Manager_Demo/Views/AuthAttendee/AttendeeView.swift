//
//  AttendeeView.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 24/05/2026.
//

import SwiftUI

// USAGE: Attendee to continue as auth user to see list of saved events and cancel event or ask for refund

struct AttendeeView: View {
    var body: some View {
            VStack {
                
                // MARK: Top Bar
                HStack {
                    
                    // MARK: Back Button
                    Button {
                    } label: {
                        Label("Back to browse events", systemImage: "arrow.left")
                    }
                    
                    Spacer()
                    
                    // MARK: Logout Button
                    Button {
                        // Logout action
                    } label: {
                        Label("Logout", systemImage: "person.crop.circle.badge.xmark")
                    }
                }
                .padding(.horizontal)
                .padding(.top)
                
                // MARK: Title
                Text("Registered Events")
                    .font(.title)
                    .padding()
                
                // MARK: Reusable Event Card with ID
                EventCard(eventID: UUID())
                
                // MARK: Bottom Cancel Registration Button or delete a saved event
                HStack {
                    Button {
                    } label: {
                        Label("Request refund", systemImage: "sign.fill")
                    }
                    Spacer()
                    Button {
                    } label: {
                        Label("", systemImage: "trash")
                    }
                
                }
            }
        }
    }
#Preview {
    AttendeeView()
}
