//
//  ViewController.swift
//  Movie Search App
//
//  Created by Minh Do on 10/9/19.
//  Copyright © 2019 Minh Do. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesCollectionView.dataSource = self
        moviesCollectionView.delegate = self
        searchBar.delegate = self
        movies = []
        imageCache = []
    }
    
    @IBAction func searchClicked(_ sender: Any) {
        spinnerView.startAnimating()
        let titleSearch = self.searchBar.text!
        DispatchQueue.global(qos: .userInitiated).async {
            
            self.fetchMovies(title: titleSearch)
            self.cacheImage()
            
            DispatchQueue.main.async {
                self.moviesCollectionView.reloadData()
                self.spinnerView.stopAnimating()
            }
        }
    }
//    func searchBar(_ searchBar: UISearchBar, textDidChange: String) {
//        spinnerView.startAnimating()
//        DispatchQueue.global(qos: .userInitiated).async {
//
//            self.fetchMovies(title: textDidChange)
//            self.cacheImage()
//
//            DispatchQueue.main.async {
//                self.moviesCollectionView.reloadData()
//                self.spinnerView.stopAnimating()
//            }
//        }
//
//    }
    
    @IBOutlet weak var spinnerView: UIActivityIndicatorView!
    
    var movies:[Movie]!
    var imageCache:[UIImage]!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! Cell
        cell.backgroundView = UIImageView(image: imageCache[indexPath.row])
        cell.title.text! = movies[indexPath.row].title
        
        return cell
    }
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    func fetchMovies(title: String) {
        movies = []
        let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=df6faad0df8113236073718d1d9374ca&query=" + title.replacingOccurrences(of: " ", with: "%20") )
        let data = try? Data(contentsOf: url!)
        if (data == nil) {
            movies = []
            return
        }
        let json = try? JSONDecoder().decode(APIResults.self, from: data!)
        
        if json == nil {
            movies = []
            return
        }
        
        var movieNum:Int = 0
        for result in json!.results {
            if (movieNum == 20) {
                break
            }
            else {
                movies.append(result)
                movieNum += 1
            }
        }
        
    }
    
    func cacheImage() {
        imageCache = []
        for movie in movies {
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showMovieInfo", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "showMovieInfo" {
            let dest = segue.destination as? MovieInfoViewController
            let movieIndex = sender as! Int
            dest!.movie = movies[movieIndex]
            dest!.movieImage = imageCache[movieIndex]
        }
    }
    

}

