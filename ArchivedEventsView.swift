//
//  ArchivedEventsView.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 22/05/2026.
//

import SwiftUI

// USAGE: Admin to archive and then delete events

struct ArchivedEventsView: View {
    var body: some View {
        //        MARK: title
        Label("Archive Events", systemImage: "document")
            .font(.title)
            .padding()
        //        MARK: Top nav button
        Button {
        } label: {
            Label("Back to browse events", systemImage: "arrow.left")
        }
        .frame(maxWidth: 500, alignment: .leading)
        .padding()
        VStack{
            //        MARK: reusable event card
            EventCard()
            
            // MARK: Bottom delete button
            HStack {
                Text("Keep or delete?")
                
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
    ArchivedEventsView()
}
