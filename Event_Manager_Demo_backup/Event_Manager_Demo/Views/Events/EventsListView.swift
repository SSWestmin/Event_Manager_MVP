//
//  EventsListView.swift
//  Event_Manager_MVP
//
//  Created by Sumi Sastri on 21/05/2026.
//

import SwiftUI

// USAGE: Public views to browse - with search view
// tab views for calendars
// search field to be added after API call to test search functionality

struct EventsListView: View {
    var body: some View {
        //         MARK: title
        Text("Browse Events")
            .font(.title)
        //         MARK: Map & Calendar Views
        HStack{
            Button {
            } label: {
                Label("Map View", systemImage: "arrow.left")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            Button {
            } label: {
                Label("Calendar View", systemImage: "arrow.right")
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        //       Call API and loop through cards to display more details nav in VStack
        //         MARK: reusable event preview card
        VStack{
            EventPreviewCard()
            //                MARK: Bottom nav button
            Button {
            } label: {
                Label("More details", systemImage: "arrow.right")
            }
            .frame(maxWidth: 500, alignment: .trailing)
        }
        
    }
}

#Preview {
    EventsListView()
}




