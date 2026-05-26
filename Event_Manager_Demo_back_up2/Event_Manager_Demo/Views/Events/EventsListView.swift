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
        NavigationStack {
            //         MARK: title
            Text("Browse Events")
                .font(.title)
            //         MARK: Map & Calendar Views
            HStack{
                NavigationLink(destination: InteractiveMapView()) {
                    Label("Map View", systemImage: "arrow.left")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                NavigationLink(destination: CalendarListView()) {
                    Label("Calendar View", systemImage: "arrow.right")
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
EventPreviewCard()
           
        }
    }
}

#Preview {
    EventsListView()
}




