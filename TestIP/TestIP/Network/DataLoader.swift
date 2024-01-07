//
//  DataLoader.swift
//  TestIP
//
//  Created by Eugen Lukashuk on 07.01.2024.
//

import Foundation

class DataLoader {
    
    func fetchGeo(ip: String) async throws -> GeoRespose? {
        guard let url = createGeoURL(ip: ip) else { return nil }
        let response = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        let result = try decoder.decode(GeoRespose.self, from: response.0)
        return result
    }
    
    func fetchUserIP() async throws -> UserIPResponse? {
        guard let url = createUserIpURL() else { return nil }
        let response = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        let result = try decoder.decode(UserIPResponse.self, from: response.0)
        return result
    }
    
    private func createGeoURL(ip: String) -> URL? {
        let server = "https://ipinfo.io/"
        let endpoint = "/geo"
        let urlStr = server + ip + endpoint
        let url = URL(string: urlStr)
        return url
    }
    
    private func createUserIpURL() -> URL? {
        let endpoint = "https://api.ipify.org/?format=json"
        let url = URL(string: endpoint)
        return url
    }
}
