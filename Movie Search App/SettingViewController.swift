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
        movieLanguagePickerView.delegate = self
        movieLanguagePickerView.dataSource = self
        var languagePicked = UserDefaults.standard.string(forKey: "languagePicked")
        if languagePicked == nil {
            languagePicked = "en"
        }

        for i in 0..<languageCode.count {
            if languageCode[i] == languagePicked! {
                movieLanguagePickerView.selectRow(i, inComponent: 0, animated: false)
                break
            }
        }
        let includeAdult = UserDefaults.standard.bool(forKey: "includeAdult")
        if includeAdult == false {
            includeAdultSwitch.setOn(false, animated: false)
        } else {
            includeAdultSwitch.setOn(true, animated: false)
        }
        
    }
    
    @IBOutlet var movieLanguagePickerView: UIPickerView! = UIPickerView()
    @IBOutlet weak var includeAdultSwitch: UISwitch!
    
    let languages = ["English", "Spanish", "French", "German", "Chinese", "Italian"]
    let languageCode = ["en", "es", "fr", "de", "zh", "it"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languages[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        UserDefaults.standard.set(languageCode[row], forKey:"languagePicked")

    }
    
    @IBAction func changeIncludeAdult(_ sender: Any) {
        UserDefaults.standard.set(includeAdultSwitch.isOn, forKey: "includeAdult")
    }
}


