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
    @State private var searchText: String = ""

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

            VStack{
                // MARK: Insert search bar to search each card and search by
                // data on the preview card
                TextField("Search events by name or location", text: $searchText)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color(.darkGray), lineWidth: 1.5)
                    )
                    .padding(.horizontal)
                    .padding(.bottom, 8)
                // MARK: Loop through API data to display event preview cards
                EventPreviewCard()
            }
        }
    }
}

#Preview {
    EventsListView()
}




