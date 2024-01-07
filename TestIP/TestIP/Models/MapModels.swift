//
//  MapModels.swift
//  TestIP
//
//  Created by Eugen Lukashuk on 07.01.2024.
//

import Foundation
import MapKit

struct MapLocation: Identifiable {
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
