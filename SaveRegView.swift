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
        
        VStack{
            //        MARK: Top nav button
            Button {
            } label: {
                Label("Back to browse events", systemImage: "arrow.left")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            //         MARK: reusabe event card
            EventCard()
        }
        //        MARK: Save button
        Button {
            
        } label: {
            Label("Save to faves", systemImage: "heart.fill")
        }
    }
}
#Preview {
    SaveRegView()
}
