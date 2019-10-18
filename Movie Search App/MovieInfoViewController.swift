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
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
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
    }
    
}

