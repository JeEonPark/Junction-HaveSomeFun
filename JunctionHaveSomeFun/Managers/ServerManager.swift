//
//  ServerManager.swift
//  JunctionHaveSomeFun
//
//  Created by DevJonny on 2024/8/10.
//

import Foundation
import Combine

class ServerManager {
    func fetchHelloWorld(completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "http://35.202.228.25:8080/api/test") else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            
            guard let data = data, let responseString = String(data: data, encoding: .utf8) else {
                completion(.failure(URLError(.badServerResponse)))
                                return
            }
            
            completion(.success(responseString))
        }
        
        task.resume()
    }
    
    
    func fetchLocationInfo(
        latitude: Double,
        longitude: Double,
        time: String? = nil,
        minPopulation: Int = 0,
        maxPopulation: Int = 0,
        minLux: Int = 0,
        maxLux: Int = 0,
        minDecibel: Int = 0,
        maxDecibel: Int = 0,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        var urlComponents = URLComponents(string: "http://35.202.228.25:8080/api/location/info")
        urlComponents?.queryItems = [
            URLQueryItem(name: "latitude", value: "\(latitude)"),
            URLQueryItem(name: "longitude", value: "\(longitude)"),
            URLQueryItem(name: "time", value: time),
            URLQueryItem(name: "minPopulation", value: "\(minPopulation)"),
            URLQueryItem(name: "maxPopulation", value: "\(maxPopulation)"),
            URLQueryItem(name: "minLux", value: "\(minLux)"),
            URLQueryItem(name: "maxLux", value: "\(maxLux)"),
            URLQueryItem(name: "minDecibel", value: "\(minDecibel)"),
            URLQueryItem(name: "maxDecibel", value: "\(maxDecibel)")
        ]
        
        guard let url = urlComponents?.url else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, let responseString = String(data: data, encoding: .utf8) else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            completion(.success(responseString))
        }
        
        task.resume()
    }




}
