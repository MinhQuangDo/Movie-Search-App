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
    
    var movieTitle:String?
    
    @IBOutlet weak var releaseYearLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        displayMovieInfo()

    }
    
    
    func displayMovieInfo() {
        releaseYearLabel.text = "Released Date: " + movie.release_date
    }
    
    
    
}

