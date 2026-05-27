//
//  GeoLocationViewModel.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 27/05/2026.
//

import Foundation
import MapKit
import Combine


@MainActor
class GeoLocationViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var locations: [GeoLocationModel] = []
    @Published var searchText: String = ""
    @Published var selectedLocation: GeoLocationModel?
    // MARK: - Map Region
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 51.5074,
            longitude: -0.1278
        ), // London
        
        span: MKCoordinateSpan(
            latitudeDelta: 0.05,
            longitudeDelta: 0.05
        )
    )

    // MARK: - Filtered Locations
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

    // MARK: - Methods
    func addLocation(_ location: GeoLocationModel) {
        locations.append(location)
    }

    func removeLocation(_ location: GeoLocationModel) {
        locations.removeAll {
            $0.geolocation_id == location.geolocation_id
        }
    }

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
    
}
