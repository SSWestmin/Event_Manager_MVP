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
        Text("Browse our events")
            .font(.title)
        //         MARK: tab views
        HStack{
            Text("Map View")
            Text("Calendar View")
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




