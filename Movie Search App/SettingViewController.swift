//
//  SettingViewController.swift
//  Movie Search App
//
//  Created by Minh Do on 10/18/19.
//  Copyright © 2019 Minh Do. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerBizCat.delegate = self
        pickerBizCat.dataSource = self
    }
    
    @IBOutlet var pickerBizCat: UIPickerView! = UIPickerView()
    let genres = ["Any", "Action", "Adventure", "Animation", "Comedy", "Crime", "Documentary", "Horror", "Romance", "Science Fiction"]
    
    let genreKeys = ["", "28", "12", "16", "35", "80", "99", "27", "10749", "878"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genres.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genres[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

    }
    
}

//{
//    "id": 28,
//    "name": "Action"
//},
//{
//    "id": 12,
//    "name": "Adventure"
//},
//{
//    "id": 16,
//    "name": "Animation"
//},
//{
//    "id": 35,
//    "name": "Comedy"
//},
//{
//    "id": 80,
//    "name": "Crime"
//},
//{
//    "id": 99,
//    "name": "Documentary"
//},
//    "id": 27,
//    "name": "Horror"
//},
//{
//    "id": 10749,
//    "name": "Romance"
//},
//{
//    "id": 878,
//    "name": "Science Fiction"

