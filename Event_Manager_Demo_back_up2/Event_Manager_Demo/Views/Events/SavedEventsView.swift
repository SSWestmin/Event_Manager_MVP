//
//  SavedEventsView.swift
//  Event_Manager_MVP
//
//  Created by Sumi Sastri on 21/05/2026.
//

import SwiftUI

// USAGE: Session based saved views - allows user to then register or delete events to short list of events they are interested in

struct SavedEventsView: View {
    var body: some View {
        //        MARK: title
        Label("Saved Events", systemImage: "heart.fill")
            .font(.title)
        
        //        MARK: Top nav button
        Button {
        } label: {
            Label("Back to browse events", systemImage: "arrow.left")
        }         .frame(maxWidth: .infinity, alignment: .leading)
        
            .padding()
        VStack{
            //            MARK: resuable event card with ID
            EventCard(eventID: UUID())
            // MARK: Bottom nav buttons register or delete event saved
            HStack {
                Button {
                } label: {
                    Label("Register", systemImage: "sign.fill")
                }
                Spacer()
                Button {
                } label: {
                    Label("", systemImage: "trash")
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    SavedEventsView()
}
