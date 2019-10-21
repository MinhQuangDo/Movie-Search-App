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
        view.backgroundColor = UIColor.white
        displayMovieInfo()
        let favoriteMovieId = UserDefaults.standard.array(forKey: "favoriteMovieId") as? [Int]
        if favoriteMovieId != nil {
            for id in favoriteMovieId! {
                if id == movie.id {
                    addToFavoriteButton.isEnabled = false
                    break
                }
            }
        }
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
        addToFavoriteButton.isEnabled = false
    }
    
}

