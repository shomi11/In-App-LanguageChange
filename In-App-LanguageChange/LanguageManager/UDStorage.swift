//
//  UDStorage.swift
//  In-App-LanguageChange
//
//  Created by Milos Malovic on 19.12.20..
//

import Foundation


class UDStorage {

  // MARK: - Private properties

  private var defaults: UserDefaults {
    UserDefaults.standard
  }

  // MARK: - Methods

  func string(forKey key: DefaultsKeys) -> String? {
    defaults.string(forKey: key.rawValue)
  }

  func set(_ value: String, forKey: DefaultsKeys) {
    defaults.set(value, forKey: forKey.rawValue)
  }
}

enum DefaultsKeys: String {
  case selectedLanguage = "LanguageManagerSelectedLanguage"
  case defaultLanguage = "LanguageManagerDefaultLanguage"
}
