//
//  FavoritesViewController.swift
//  Movie Search App
//
//  Created by Minh Do on 10/12/19.
//  Copyright © 2019 Minh Do. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var favoriteMovies:[Movie]!
    var imageCache:[UIImage]!
    
    @IBOutlet weak var favoriteMovieTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteMovieTableView.delegate = self
        favoriteMovieTableView.dataSource = self
        favoriteMovies = []
        imageCache = []
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.global(qos: .userInitiated).async {
            var favoriteMovieId = UserDefaults.standard.array(forKey: "favoriteMovieId") as? [Int]
            if favoriteMovieId == nil {
                favoriteMovieId = []
            }
            
            self.fetchMovieById(ids: favoriteMovieId!)
            self.cacheImage()
            
            DispatchQueue.main.async {
                self.favoriteMovieTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        myCell.textLabel?.text = String(favoriteMovies[indexPath.row].title)
        return myCell
    }
    
    
    @IBAction func deleteAllClicked(_ sender: Any) {
        favoriteMovies = []
        favoriteMovieTableView.reloadData()
        UserDefaults.standard.set([], forKey:"favoriteMovieId")
    }
    
    func fetchMovieById (ids: [Int]) {
        favoriteMovies = []
        for id in ids {
            let url = URL(string: "https://api.themoviedb.org/3/movie/" + String(id) + "?api_key=df6faad0df8113236073718d1d9374ca&query=")
            let data = try? Data(contentsOf: url!)
            if (data == nil) {
                return
            }
            let json = try! JSONDecoder().decode(Movie.self, from: data!)
            favoriteMovies.append(json)
        }
    }
    
    func cacheImage() {
        imageCache = []
        for movie in favoriteMovies {
            if movie.poster_path == nil {
                imageCache.append(UIImage(named: "question_mark.png")!)
                continue
            }
            let url = URL(string: "https://image.tmdb.org/t/p/w185/" + movie.poster_path!)
            let data = try? Data(contentsOf: url!)
            if data == nil {
                imageCache.append(UIImage(named: "question_mark.png")!)
                continue
            }
            let image = UIImage(data: data!)!
            imageCache.append(image)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showFavoriteMovie", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "showFavoriteMovie" {
            let destination = segue.destination as? MovieInfoViewController
            let movieIndex = sender as! Int
            destination!.movie = favoriteMovies[movieIndex]
            destination!.movieImage = imageCache[movieIndex]
        }
    }
    
}

