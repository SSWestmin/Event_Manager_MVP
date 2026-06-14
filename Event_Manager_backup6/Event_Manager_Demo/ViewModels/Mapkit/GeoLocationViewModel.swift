//
//  GeoLocationViewModel.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 27/05/2026.
//

import Foundation
import MapKit
import Combine


// USAGE: Events SSOT drives map views and local state updates

@MainActor
class GeoLocationViewModel: ObservableObject {
    // MARK: - Search State
    @Published var searchText: String = ""
    // MARK: - Geoloc
    @Published var locations: [GeoLocationModel] = []
    @Published var selectedLocation: GeoLocationModel?
    
    // MARK: - Map Region
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 51.5074,
            longitude: -0.1278
        ), // London hardcoded (research how to do this with user device)
        
        span: MKCoordinateSpan(
            latitudeDelta: 0.05,
            longitudeDelta: 0.05
        )
    )
    
    //    MARK: Empty initialiser placeholder
    init() {}

    // MARK: - Populate locations from EventModel array
    func populateLocations(from events: [EventModel]) {
        // Map each event to a GeoLocationModel and assign to locations
        self.locations = events.map { event in
            GeoLocationModel(
                locationName: event.eventName + ", " + event.eventLocation,
                latitude: event.latitude,
                longitude: event.longitude
            )
        }
    }

    // MARK: - Filtered Locations on a map
    var filteredLocations: [GeoLocationModel] {
        let search = searchText
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
        
        if search.isEmpty {
            return locations
        }
        
        return locations.filter {
            $0.locationName.lowercased().contains(search)
        }
    }
    
    // MARK: Select location
    func selectLocation(_ location: GeoLocationModel) {
        
        selectedLocation = location
        
        region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: location.latitude,
                longitude: location.longitude
            ),
            
            span: MKCoordinateSpan(
                latitudeDelta: 0.05,
                longitudeDelta: 0.05
            )
        )
    }

    // MARK: CRUD (add, delete - no update this is read-only functionality for all users)
    // refactor with environment obj/ @query and persitent data)
    
    func addLocation(_ location: GeoLocationModel) {
        locations.append(location)
    }

    func removeLocation(_ location: GeoLocationModel) {
        locations.removeAll {
            $0.geolocation_id == location.geolocation_id
        }
    }

}
