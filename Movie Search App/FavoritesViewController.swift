//
//  FavoritesViewController.swift
//  Movie Search App
//
//  Created by Minh Do on 10/12/19.
//  Copyright © 2019 Minh Do. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var movieTitles:[String]!
    @IBOutlet weak var favoriteMovieTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteMovieTableView.delegate = self
        favoriteMovieTableView.dataSource = self
        movieTitles = []
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.global(qos: .userInitiated).async {
            var favoriteMovies = UserDefaults.standard.array(forKey: "favoriteMovies") as? [String]
            if favoriteMovies == nil {
                favoriteMovies = []
            }
            self.movieTitles = favoriteMovies!
            DispatchQueue.main.async {
                self.favoriteMovieTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        myCell.textLabel?.text = movieTitles[indexPath.row]
        return myCell
    }
    
    
    
    
}
