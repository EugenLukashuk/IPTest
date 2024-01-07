//
//  MapViewModel.swift
//  TestIP
//
//  Created by Eugen Lukashuk on 07.01.2024.
//

import Foundation

class MapViewModel: ObservableObject {
    let locationStr: String
    var mapLocations: [MapLocation] = []
    
    init(locationStr: String) {
        self.locationStr = locationStr
        mapLocations = [
            MapLocation(name: "",
                        latitude: getLat(),
                        longitude: getLon())]
    }
    
    func getLat() -> Double {
        let components = locationStr.components(separatedBy: ",")
        let lat = Double(components.first ?? "")
        return lat ?? 0
    }
    
    func getLon() -> Double {
        let components = locationStr.components(separatedBy: ",")
        let lon = Double(components.last ?? "")
        return lon ?? 0
    }
}
