//
//  EventsListView.swift
//  Event_Manager_MVP
//
//  Created by Sumi Sastri on 21/05/2026.
//

import SwiftUI

// USAGE: List view navs to map and calendar view with search bar
// Nav stack provides immediate nav back to this view


struct EventsListView: View {
    @ObservedObject var viewModel: EventViewModel

    var body: some View {
        NavigationStack {
            Text("Browse Events")
                .font(.title)
            // DEBUG: Show API error if present
            if let apiError = viewModel.apiError {
                Text("API Error: \(apiError)")
                    .foregroundColor(.red)
            }
            // DEBUG: Show event count
            Text("Events loaded: \(viewModel.events.count)")
                .foregroundColor(.gray)
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
            EventPreviewCard(viewModel: viewModel)
            .navigationDestination(isPresented: $viewModel.navigateToSaved) {
                SavedEventsView(savedEvents: viewModel.savedEvents, viewModel: viewModel)
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Saved Events"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
        }
        .task {
            await viewModel.fetchEventsFromAPI()
        }
    }
}

#Preview {
    EventsListView(viewModel: EventViewModel())
}




