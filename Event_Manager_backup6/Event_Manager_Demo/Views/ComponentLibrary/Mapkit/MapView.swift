//
//  MapView.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 26/05/2026.
//

import SwiftUI
import MapKit
import SwiftData

// USAGE: Public views to search by and name of event and find event on the map
// nav back to list view

struct MapView: View {
    // MARK: - ViewModel
    @ObservedObject var eventVM: EventViewModel
    
    // MARK: - Camera Position (modern SwiftUI Map API)
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: 51.5074,
                longitude: -0.1278
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 0.2,
                longitudeDelta: 0.2
            )
        )
    )
    
    // MARK: - Body
    var body: some View {
        
        VStack(spacing: 0) {
            
            // MARK: - Title
            Text("Find Events Near You")
                .font(.title)
                .padding(.top)
            
            // MARK: - Search Field
            TextField(
                "Search for events by title",
                text: $eventVM.searchText
            )
            .padding(10)
            .background(Color.gray.opacity(0.15))
            .cornerRadius(8)
            .padding([.horizontal, .bottom])
            
            // MARK: - Map + Overlay
            ZStack {
                
                // MARK: - Map loop through filtered events and add marker
                Map(position: $cameraPosition) {
                    ForEach(eventVM.filteredEvents, id: \.event_id) { event in
                        Marker(event.eventName,
                               coordinate: CLLocationCoordinate2D(
                                latitude: event.latitude,
                                longitude: event.longitude
                               ))
                    }
                }
                .ignoresSafeArea()
                
                // MARK: - Empty State Overlay
                if eventVM.filteredEvents.isEmpty {
                    Text("No events found.")
                        .font(.callout)
                        .foregroundColor(.secondary)
                        .padding(12)
                        .background(.white.opacity(0.9))
                        .cornerRadius(10)
                        .shadow(radius: 2)
                }
            }
        }
    }
}

// MARK: - Preview - refactor import Swift Data and pass coordinator
#Preview {
    let container = try! ModelContainer(
        for: EventModel.self,
        configurations: .init(isStoredInMemoryOnly: true)
    )
    let coordinator = EventDataCoordinator(modelContext: container.mainContext)
    let viewModel = EventViewModel(coordinator: coordinator)

    MapView(eventVM: viewModel)
        .modelContainer(container)
}
