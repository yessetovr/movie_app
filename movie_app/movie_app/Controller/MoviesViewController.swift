//
//  ViewController.swift
//  movie_app
//
//  Created by Райымбек Есетов on 24.08.2025.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var movies: [Movie] = []
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Фильмы"
        view.backgroundColor = .systemBackground
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
        view.addSubview(tableView)
        tableView.frame = view.bounds
        
        loadMovies()
    }
    
    private func loadMovies() {
        NetworkManager.shared.fetchTrendingMovies { result in
            switch result {
            case .success(let movies):
                self.movies = movies
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching movies: \(error)")
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else {
            return UITableViewCell()
        }
        cell.configure(with: movies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        let detailVC = MovieDetailViewController(movieID: movie.imdb_id ?? "")
        navigationController?.pushViewController(detailVC, animated: true)
    }
}


