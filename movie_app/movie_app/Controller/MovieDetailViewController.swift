//
//  MovieDetailViewController.swift
//  movie_app
//
//  Created by Райымбек Есетов on 24.08.2025.
//

import UIKit

class MovieDetailViewController: UIViewController {
    private let movieID: String

    init(movieID: String) {
        self.movieID = movieID
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        fetchMovieDetails()
    }

    private func fetchMovieDetails() {
        let urlString = "https://movies-tv-shows-database.p.rapidapi.com/?movieid=\(movieID)"
        guard let url = URL(string: urlString) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("77e87441c3msh36e9c31224e08c2p10d58bjsn876301ca2a41", forHTTPHeaderField: "x-rapidapi-key")
        request.setValue("movies-tv-shows-database.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
        request.setValue("get-movie-details", forHTTPHeaderField: "Type")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            guard let data = data else { return }

            if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
                print("Movie details: \(json)")
            }
        }
        task.resume()
    }
}
