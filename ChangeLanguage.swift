//
//  ChangeLanguage.swift
//  In-App-LanguageChange
//
//  Created by Milos Malovic on 22.12.20..
//

import UIKit

class ChangeLanguage {
    
    static var shared = ChangeLanguage()
    
    var isSpanishSelected = UserDefaults.standard.bool(forKey: "isSpanish")
    
    
    func changeLanguage(sender: UISegmentedControl) {
        
        var selectedLanguage: Languages?
        
        switch sender.selectedSegmentIndex {
        case 0:
            selectedLanguage = .en
            UserDefaults.standard.set(false, forKey: "isSpanish")
        case 1:
            selectedLanguage = .es
            UserDefaults.standard.set(true, forKey: "isSpanish")
        default:
            break
        }
        
        LanguageManager.shared.setLanguage(language: selectedLanguage ?? .en)
        { title -> UIViewController in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            return storyboard.instantiateInitialViewController()!
        } animation: { view in
            view.transform = CGAffineTransform(scaleX: 2, y: 2)
            view.alpha = 0
        }
    }
    
    func checklanguage(segmentedController: UISegmentedControl) {
        if isSpanishSelected == true {
            segmentedController.selectedSegmentIndex = 1
        } else {
            segmentedController.selectedSegmentIndex = 0
        }
    }
}

