//
//  NetworkManager.swift
//  movie_app
//
//  Created by Райымбек Есетов on 24.08.2025.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    private let headers = [
        "x-rapidapi-key": "77e87441c3msh36e9c31224e08c2p10d58bjsn876301ca2a41",
        "x-rapidapi-host": "movies-tv-shows-database.p.rapidapi.com"
    ]
    
    func fetchTrendingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        var request = URLRequest(url: URL(string: "https://movies-tv-shows-database.p.rapidapi.com/?page=1")!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        request.addValue("get-trending-movies", forHTTPHeaderField: "Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            get 
            if let jsonString = String(data: data, encoding: .utf8) {
                print("JSON Response:\n\(jsonString)")
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(MoviesResponse.self, from: data)
                completion(.success(response.movie_results))
            } catch {
                print("JSON decoding error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

