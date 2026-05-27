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
    @State private var savedEvents: [EventModel] = []
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var navigateToSaved = false

    var body: some View {
        NavigationStack {
            Text("Browse Events")
                .font(.title)
            HStack{
                NavigationLink(destination: MapView()) {
                    Label("Map View", systemImage: "arrow.left")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                NavigationLink(destination: CalendarView()) {
                    Label("Calendar View", systemImage: "arrow.right")
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            EventPreviewCard()
            // Navigation to SavedEventsView
            .navigationDestination(isPresented: $navigateToSaved) {
                SavedEventsView(savedEvents: savedEvents)
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Saved Events"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

}

#Preview {
    EventsListView()
}




