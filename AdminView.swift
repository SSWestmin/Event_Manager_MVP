//
//  AdminView.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 22/05/2026.
//

import SwiftUI

// USAGE: Admin to manage events with CRUD actions

struct AdminView: View {
    var body: some View {
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
            Button {
            } label: {
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
                    
                    Button {
                    } label: {
                        Label("Archive event", systemImage: "arrow.left")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button {
                    } label: {
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
#Preview {
    AdminView()
}
