//
//  MapViewModel.swift
//  JunctionHaveSomeFun
//
//  Created by DevJonny on 2024/8/11.
//

import SwiftUI

struct SpotInfo: Decodable {
    let id: Int
    let time: String
    let avgDecibel: Double
    let avgLightLux: Double
    let population: Double
    let geohash7: String
}

class MapViewModel: ObservableObject {
    @Published var mappingGeohashes: [String] = []
    @Published var floatingPopulation: Double? = nil
    @Published var lighting: Double? = nil
    @Published var noise: Double? = nil
    
    let serverManager = ServerManager()
    
    func fetchLocationInfo(time: Int, minPopulation: Int, maxPopulation: Int, minLux: Int, maxLux: Int, minDecibel: Int, maxDecibel: Int) async {
        let result = await serverManager.fetchLocationInfo(time: time, minPopulation: minPopulation, maxPopulation: maxPopulation, minLux: minLux, maxLux: maxLux, minDecibel: minDecibel, maxDecibel: maxDecibel)
        
        switch result {
        case .success(let message):
            if let data = message.data(using: .utf8) {
                do {
                    let geohashes = try JSONDecoder().decode([String].self, from: data)
                    self.mappingGeohashes = Array(Set(geohashes))
                    print(self.mappingGeohashes)
                } catch {
                    print("Failed to decode JSON: \(error)")
                }
            }
        case .failure(let error):
            print("Error fetching location info: \(error)")
        }
    }
    
    func fetchSpotInfoAverage(latitude: Double, longitude: Double, time: Int) async {
        let result = await serverManager.fetchSpotInfo(latitude: latitude, longitude: longitude, time: time)
        
        switch result {
        case .success(let message):
            if let data = message.data(using: .utf8) {
                do {
                    let spotInfos = try JSONDecoder().decode([SpotInfo].self, from: data)
                    
                    let totalDecibel = spotInfos.map { $0.avgDecibel }.reduce(0, +)
                    let totalLightLux = spotInfos.map { $0.avgLightLux }.reduce(0, +)
                    let totalPopulation = spotInfos.map { $0.population }.reduce(0, +)
                    
                    let count = Double(spotInfos.count)
                    
                    self.noise = totalDecibel / count
                    self.lighting = totalLightLux / count
                    self.floatingPopulation = totalPopulation / count
                    
                    print("Noise Average: \(self.noise ?? 0)")
                    print("Lighting Average: \(self.lighting ?? 0)")
                    print("Floating Population Average: \(self.floatingPopulation ?? 0)")
                    
                } catch {
                    print("Failed to decode JSON: \(error)")
                }
            }
        case .failure(let error):
            print("Error fetching spot info: \(error)")
        }
    }
}
