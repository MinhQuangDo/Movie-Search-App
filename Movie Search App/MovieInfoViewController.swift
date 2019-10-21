//
//  MovieInfoViewController.swift
//  Movie Search App
//
//  Created by Minh Do on 10/12/19.
//  Copyright © 2019 Minh Do. All rights reserved.
//

import UIKit

class MovieInfoViewController: UIViewController {
    
    var movie:Movie!
    var movieImage:UIImage!
    
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var addToFavoriteButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let favoriteMovieId = UserDefaults.standard.array(forKey: "favoriteMovieId") as? [Int]
        if favoriteMovieId != nil {
            for id in favoriteMovieId! {
                if id == movie.id {
                    addToFavoriteButton.isEnabled = false
                    break
                }
            }
        }
        fetchImage()
        displayMovieInfo()
    }
    
    
    func displayMovieInfo() {
        self.navigationItem.title = movie.title
        posterImage.image = movieImage
        releaseYearLabel.text = "Released Date: " + movie.release_date
        scoreLabel.text = "Rating: " + String(movie.vote_average) + " / 10"
        overviewLabel.text = movie.overview
    }
    
    
    @IBAction func addToFavoriteClicked(_ sender: Any) {
        var favoriteMovieId = UserDefaults.standard.array(forKey: "favoriteMovieId") as? [Int]
        if favoriteMovieId == nil {
            favoriteMovieId = []
        }
        favoriteMovieId!.append(movie.id)
        UserDefaults.standard.set(favoriteMovieId, forKey:"favoriteMovieId")
        
        var favoriteMovieLanguage = UserDefaults.standard.array(forKey: "favoriteMovieLanguage") as? [String]
        if favoriteMovieLanguage == nil {
            favoriteMovieLanguage = []
        }
        favoriteMovieLanguage!.append(movie.language!)
        UserDefaults.standard.set(favoriteMovieLanguage, forKey:"favoriteMovieLanguage")
        
        addToFavoriteButton.isEnabled = false
    }
    
    //higher resolution
    func fetchImage() {
        if movie.poster_path == nil {
            movieImage = UIImage(named: "question_mark.png")!
            return
        }
        let url = URL(string: "https://image.tmdb.org/t/p/w342/" + movie.poster_path!)
        let data = try? Data(contentsOf: url!)
        if data == nil {
            movieImage = UIImage(named: "question_mark.png")!
            return
        }
        movieImage = UIImage(data: data!)!
        
    }
    
}

