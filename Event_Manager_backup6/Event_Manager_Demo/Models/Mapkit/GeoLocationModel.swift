//
//  GeoLocationModel.swift
//  travel-nomads-app
//
//  Created by Sumi Sastri on 07/04/2026.
//

import Foundation
import SwiftData

// USAGE: Main map to search events used in conjunction with events venue address
@Model
class GeoLocationModel: Identifiable, Equatable {
    // MARK: - Identifiable Support
    @Attribute(.unique) var geolocation_id: UUID = UUID()  // ensures unique, identifiable ID for SwiftUI
//    FIXME: Is location name the right mapping
    var locationName: String
    var latitude: Double
    var longitude: Double
    var isUserSaved: Bool?
    
    // MARK: initialisation
    init(geolocation_id: UUID = UUID(),
         locationName: String,
         latitude: Double,
         longitude: Double,
         isUserSaved: Bool? = nil)
    {
        self.geolocation_id = geolocation_id
        self.locationName = locationName
        self.latitude = latitude
        self.longitude = longitude
        self.isUserSaved = isUserSaved
    }
    
    // MARK: - Equatable Support
    static func == (lhs: GeoLocationModel, rhs: GeoLocationModel) -> Bool {
        lhs.geolocation_id == rhs.geolocation_id
    }
}

