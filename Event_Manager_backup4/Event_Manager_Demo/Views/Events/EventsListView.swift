//
//  EventsListView.swift
//  Event_Manager_MVP
//
//  Created by Sumi Sastri on 21/05/2026.
//

import SwiftUI

// USAGE: Public views to browse - with search view
//  Refactor 1: Move logic to View Model


struct EventsListView: View {
    @StateObject private var viewModel = EventViewModel()

    var body: some View {
        // MARK: Navigation to Map and Calendar views
        NavigationStack {
            Text("Browse Events")
                .font(.title)
            HStack{
                NavigationLink(destination: MapView(eventVM: viewModel)) {
                    Label("Map View", systemImage: "arrow.left")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                NavigationLink(destination: CalendarView()) {
                    Label("Calendar View", systemImage: "arrow.right")
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            // MARK: Reusable Event Card View
            EventPreviewCard(viewModel: viewModel)
            // Navigation to SavedEventsView
            .navigationDestination(isPresented: $viewModel.navigateToSaved) {
                SavedEventsView(savedEvents: viewModel.savedEvents)
            }
        }
        // MARK: Alert for saved events
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Saved Events"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
        }
    }

}

#Preview {
    EventsListView()
}




