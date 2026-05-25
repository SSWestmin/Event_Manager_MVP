//
//  SaveRegView.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 24/05/2026.
//

import SwiftUI

// USAGE: Attendee to continue as auth user to see event details from preview cards

struct SaveRegView: View {
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
                   
                   // MARK: Reusable Event Card
                   EventCard()
                   
                   Spacer()
                   
                   // MARK: Save button
                   Button {
                       
                   } label: {
                       Label("Save to faves", systemImage: "heart.fill")
                   }
                   .padding(.bottom)
               }
           }
       }
#Preview {
    SaveRegView()
}
