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
}
