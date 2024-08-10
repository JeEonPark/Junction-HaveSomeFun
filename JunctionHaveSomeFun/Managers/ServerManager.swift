//
//  ServerManager.swift
//  JunctionHaveSomeFun
//
//  Created by DevJonny on 2024/8/10.
//

import Foundation

class ServerManager {
    func fetchLocationInfo(
        time: Int = 0,
        minPopulation: Int = 0,
        maxPopulation: Int = 0,
        minLux: Int = 0,
        maxLux: Int = 0,
        minDecibel: Int = 0,
        maxDecibel: Int = 0
    ) async -> Result<String, Error> {
        var urlComponents = URLComponents(string: "http://35.202.228.25:8080/api/location/info")
        urlComponents?.queryItems = [
            URLQueryItem(name: "time", value: "\(time)"),
            URLQueryItem(name: "minPopulation", value: "\(minPopulation)"),
            URLQueryItem(name: "maxPopulation", value: "\(maxPopulation)"),
            URLQueryItem(name: "minLux", value: "\(minLux)"),
            URLQueryItem(name: "maxLux", value: "\(maxLux)"),
            URLQueryItem(name: "minDecibel", value: "\(minDecibel)"),
            URLQueryItem(name: "maxDecibel", value: "\(maxDecibel)")
        ]
        
        guard let url = urlComponents?.url else {
            return .failure(URLError(.badURL))
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let responseString = String(data: data, encoding: .utf8) else {
                return .failure(URLError(.badServerResponse))
            }
            return .success(responseString)
        } catch {
            return .failure(error)
        }
    }
    
    func fetchSpotInfo(
        latitude: Double,
        longitude: Double,
        time: Int
    ) async -> Result<String, Error> {
        var urlComponents = URLComponents(string: "http://35.202.228.25:8080/api/location/spot/info")
        urlComponents?.queryItems = [
            URLQueryItem(name: "latitude", value: "\(latitude)"),
            URLQueryItem(name: "longitude", value: "\(longitude)"),
            URLQueryItem(name: "time", value: "\(time)")
        ]
        
        guard let url = urlComponents?.url else {
            return .failure(URLError(.badURL))
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let responseString = String(data: data, encoding: .utf8) else {
                return .failure(URLError(.badServerResponse))
            }
            return .success(responseString)
        } catch {
            return .failure(error)
        }
    }
}
