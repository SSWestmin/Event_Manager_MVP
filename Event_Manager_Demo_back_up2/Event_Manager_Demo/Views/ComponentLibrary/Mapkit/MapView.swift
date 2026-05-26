//
//  CalendarListView.swift
//  Event_Manager_Demo
//
//  Created by Sumi Sastri on 26/05/2026.
//


import SwiftUI
import MapKit
import CoreLocation
import Combine


// MARK: Stubbed events with postcodes and coordinates
let stubbedEvents: [EventModel] = [
    EventModel(
        event_id: UUID(),
        eventName: "London Tech Meetup",
        eventDescription: "A meetup for London tech enthusiasts.",
        eventStart: Calendar.current.date(bySettingHour: 18, minute: 0, second: 0, of: Date())!,
        eventEnd: Calendar.current.date(bySettingHour: 21, minute: 0, second: 0, of: Date())!,
        eventLocation: "W1J 8PG",
        ticketPrice: 10.0,
        latitude: 51.5045, longitude: -0.1501 // W1J 8PG
    ),
    EventModel(
        event_id: UUID(),
        eventName: "Mayfair Business Brunch",
        eventDescription: "Networking brunch for business professionals.",
        eventStart: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
        eventEnd: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
        eventLocation: "W1K 2AB",
        ticketPrice: 12.0,
        latitude: 51.5112, longitude: -0.1507 // W1K 2AB
    ),
    EventModel(
        event_id: UUID(),
        eventName: "Green Park Picnic",
        eventDescription: "Outdoor picnic event at Green Park.",
        eventStart: Calendar.current.date(byAdding: .day, value: 2, to: Date())!,
        eventEnd: Calendar.current.date(byAdding: .day, value: 2, to: Date())!,
        eventLocation: "W1J 7AF",
        ticketPrice: 15.0,
        latitude: 51.5057, longitude: -0.1426 // W1J 7AF
    )
]


struct MapView: View {
    // MARK: Search text for filtering events by postcode
    @State private var searchText: String = ""
    // MARK: Location manager to handle user location and permissions
    @StateObject private var locationManager = LocationManager()
    // MARK: Initial region centered on London with a reasonable zoom level
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.5074, longitude: -0.1278), // London
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    // MARK: Camera position for MapKit
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 51.5074, longitude: -0.1278), // London
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    )
    
    var body: some View {
        VStack(spacing: 0) {
            //        MARK: title
            VStack(spacing: 20) {
                Text("Find Events Near You")
                    .font(.title)
                // MARK: Search bar
                TextField("Search for events by postcode", text: $searchText)
                    .padding(10)
                    .background(Color.gray.opacity(0.15))
                    .cornerRadius(8)
                    .padding([.horizontal, .top])
            }
            ZStack {
                Group {
                    if filteredEvents.isEmpty {
                        Map(position: $cameraPosition, interactionModes: .all) {
                            UserAnnotation()
                        }
                        .ignoresSafeArea()
                        Text("No events in that postcode.")
                            .foregroundColor(.secondary)
                            .padding()
                            .background(Color.white.opacity(0.8), alignment: .center)
                            .cornerRadius(10)
                            .padding(.top, 100)
                    } else {
                        Map(position: $cameraPosition, interactionModes: .all) {
                            UserAnnotation()
                            ForEach(filteredEvents, id: \.event_id) { event in
                                Marker("\(event.eventName) (\(event.eventLocation))", coordinate: CLLocationCoordinate2D(latitude: event.latitude, longitude: event.longitude))
                            }
                        }
                        .ignoresSafeArea()
                    }
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        if locationManager.isLoading {
                            ProgressView()
                                .padding()
                        }
                    }
                }
            }
            .onAppear {
                zoomToFitAllEvents()
            }
            .onReceive(locationManager.$location) { location in
                if let location = location {
                    let newRegion = MKCoordinateRegion(
                        center: location.coordinate,
                        span: region.span
                    )
                    region = newRegion
                    cameraPosition = .region(newRegion)
                }
            }
        }
    }

    // MARK: Utility functions filtered events based on search text
    var filteredEvents: [EventModel] {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return stubbedEvents
        }
        return stubbedEvents.filter { event in
            event.eventLocation.localizedCaseInsensitiveContains(searchText)
        }
    }

    // MARK: Zoom the map to fit all event markers
    func zoomToFitAllEvents() {
        guard !stubbedEvents.isEmpty else { return }
        let lats = stubbedEvents.map { $0.latitude }
        let lons = stubbedEvents.map { $0.longitude }
        guard let minLat = lats.min(), let maxLat = lats.max(), let minLon = lons.min(), let maxLon = lons.max() else { return }
        let centerLat = (minLat + maxLat) / 2
        let centerLon = (minLon + maxLon) / 2
        let spanLat = (maxLat - minLat) * 1.5 + 0.01
        let spanLon = (maxLon - minLon) * 1.5 + 0.01
        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: centerLat, longitude: centerLon),
            span: MKCoordinateSpan(latitudeDelta: max(spanLat, 0.01), longitudeDelta: max(spanLon, 0.01))
        )
        self.region = region
        self.cameraPosition = .region(region)
    }
        }
        
        // MARK: Custom annotation for user location
        class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
            private let manager = CLLocationManager()
            @Published var location: CLLocation?
            @Published var isLoading = false
            
            override init() {
                super.init()
                manager.delegate = self
                manager.desiredAccuracy = kCLLocationAccuracyBest
                checkLocationAuthorization()
            }
            // MARK: Location authorization handling and updates
            private func checkLocationAuthorization() {
                switch manager.authorizationStatus {
                case .notDetermined:
                    isLoading = true
                    manager.requestWhenInUseAuthorization()
                case .authorizedWhenInUse, .authorizedAlways:
                    isLoading = true
                    manager.startUpdatingLocation()
                default:
                    isLoading = false
                }
            }
            // MARK: CLLocationManagerDelegate methods
            func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
                checkLocationAuthorization()
            }
            // MARK: Update location and handle errors
            func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                location = locations.first
                isLoading = false
                manager.stopUpdatingLocation()
            }
            // MARK: Handle location errors
            func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
                isLoading = false
            }
        }
    
// Preview
#if DEBUG
struct MapView_Previews: PreviewProvider {
	static var previews: some View {
		MapView()
	}
}
#endif
