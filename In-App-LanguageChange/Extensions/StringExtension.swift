//
//  StringExtension.swift
//  In-App-LanguageChange
//
//  Created by Milos Malovic on 19.12.20..
//

import Foundation

extension String {

    func localiz(comment: String = "") -> String {
        guard let bundle = Bundle.main.path(forResource: LanguageManager.shared.currentLanguage.rawValue, ofType: "lproj") else {
            return NSLocalizedString(self, comment: comment)
        }
        
        let langBundle = Bundle(path: bundle)
        return NSLocalizedString(self, tableName: nil, bundle: langBundle!, comment: comment)
    }
}

