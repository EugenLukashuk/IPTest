//
//  MainViewModel.swift
//  TestIP
//
//  Created by Eugen Lukashuk on 05.01.2024.
//

import Foundation
import SwiftUI

class MainViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var results: [ResultEntity] = []
    @Published var errorTitle = "" 
    @Published var errorMessage = ""
    @Published var isErrorShown = false
    @Published var isTextValid = false
    @Published var textFieldColor = Color.white
    @Published var isLoading = false
    @Published var isShowMap = false
    var location = ""
    
    private let dataLoader = DataLoader()
    
    func getGeo() {
        results = []
        switchIsLoading(true)
        
        Task {
            let result = try await self.dataLoader.fetchGeo(ip: searchText)
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.setupEntity(result: result)
            }
        }
    }
    
    func findMe() {
        results = []
        switchIsLoading(true)
        searchText = ""
        textFieldColor = .white
        
        Task {
            let result = try await self.dataLoader.fetchUserIP()
            
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.searchText = result?.ip ?? ""
            }
        }
        
        getGeo()
    }
    
    func reset() {
        searchText = ""
        results = []
        errorMessage = ""
        isErrorShown = false
        textFieldColor = .white
        isLoading = false
        isShowMap = false
    }
    
    func textFieldValidator() {
        let format = "\\b(?:\\d{1,3}\\.){3}\\d{1,3}\\b"
        let predicate = NSPredicate(format: "SELF MATCHES %@", format)
        isTextValid = predicate.evaluate(with: searchText)
        
        if searchText.isEmpty {
            textFieldColor = .white
        } else {
            textFieldColor = isTextValid ? .green : .red
        }
    }
    
    private func switchIsLoading(_ isLoading: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.isLoading = isLoading
        }
    }
    
    private func setupEntity(result: GeoRespose?) {
        switchIsLoading(false)
        
        if let error = result?.error {
            errorTitle = error.title ?? "Error"
            errorMessage = error.message ?? ""
            isErrorShown = true
            isShowMap = false
            return
        }
        
        location = result?.loc ?? ""
        isShowMap = true
        
        var entities: [ResultEntity] = []
        
        let ip = ResultEntity(id: 0, name: "IP", value: result?.ip ?? "")
        let city = ResultEntity(id: 1, name: "City", value: result?.city ?? "")
        let country = ResultEntity(id: 2, name: "Country", value: result?.country ?? "")
        let hostname = ResultEntity(id: 3, name: "Hostname", value: result?.hostname ?? "")
        let region = ResultEntity(id: 4, name: "Region", value: result?.region ?? "")
        let postal = ResultEntity(id: 5, name: "Postal", value: result?.postal ?? "")
        let timezone = ResultEntity(id: 6, name: "Timezone", value: result?.timezone ?? "")
        
        entities.append(ip)
        entities.append(city)
        entities.append(country)
        entities.append(hostname)
        entities.append(region)
        entities.append(postal)
        entities.append(timezone)
        
        results = entities
        searchText = result?.ip ?? ""
    }
}
