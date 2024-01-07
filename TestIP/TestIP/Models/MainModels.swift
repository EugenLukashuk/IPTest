//
//  MainModels.swift
//  TestIP
//
//  Created by Eugen Lukashuk on 05.01.2024.
//

import Foundation

struct ResultEntity: Identifiable {
    var id: Int64
    let name: String
    let value: String
}

struct GeoRespose: Codable {
    let ip: String?
    let hostname: String?
    let city: String?
    let region: String?
    let country: String?
    let loc: String?
    let postal: String?
    let timezone: String?
    let error: ErrorResponse?
}

struct UserIPResponse: Codable {
    let ip: String?
    let error: ErrorResponse?
}

struct ErrorResponse: Codable {
    let title: String?
    let message: String?
}
