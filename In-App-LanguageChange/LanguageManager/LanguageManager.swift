//
//  LanguageManager.swift
//  In-App-LanguageChange
//
//  Created by Milos Malovic on 19.12.20..
//

import Foundation
import UIKit


class LanguageManager {
    
    public typealias Animation = ((UIView) -> Void)
    public typealias ViewControllerFactory = ((String?) -> UIViewController)
    public typealias WindowAndTitle = (UIWindow?, String?)
    
    static let shared: LanguageManager = LanguageManager()
    
    private var storage = UDStorage()
    
    private(set) var currentLanguage: Languages {
        get {
            guard let currentLang = storage.string(forKey: .selectedLanguage) else {
                fatalError("Did you set the default language for the app?")
            }
            return Languages(rawValue: currentLang)!
        }
        set {
            storage.set(newValue.rawValue, forKey: .selectedLanguage)
        }
    }
    
    var defaultLanguage: Languages {
        get {
            guard let defaultLanguage = storage.string(forKey: .defaultLanguage) else {
                fatalError("Did you set the default language for the app?")
            }
            return Languages(rawValue: defaultLanguage)!
        }
        set {
            // swizzle the awakeFromNib from nib and localize the text in the new awakeFromNib
            UIView.localize()
            
            let defaultLanguage = storage.string(forKey: .defaultLanguage)
            guard defaultLanguage == nil else {
                // If the default language has been set before,
                // that means that the user opened the app before and maybe
                // he changed the language so here the `currentLanguage` is being set.
                setLanguage(language: currentLanguage)
                return
            }
            
            var language = newValue
            if language == .deviceLanguage {
                language = deviceLanguage ?? .en
            }
            
            storage.set(language.rawValue, forKey: .defaultLanguage)
            storage.set(language.rawValue, forKey: .selectedLanguage)
            setLanguage(language: language)
        }
    }
    
    private func isLanguageRightToLeft(language: Languages) -> Bool {
        return Locale.characterDirection(forLanguage: language.rawValue) == .rightToLeft
    }
    
    var isRightToLeft: Bool {
        get {
            return isLanguageRightToLeft(language: currentLanguage)
        }
    }
    
    var deviceLanguage: Languages? {
        get {
            guard let deviceLanguage = Bundle.main.preferredLocalizations.first else {
                return nil
            }
            return Languages(rawValue: deviceLanguage)
        }
    }
    
    var appLocale: Locale {
        get {
            return Locale(identifier: currentLanguage.rawValue)
        }
    }
    
    private func changeCurrentLanguageTo(_ language: Languages) {
        // change the dircation of the views
        let semanticContentAttribute: UISemanticContentAttribute = isLanguageRightToLeft(language: language) ? .forceRightToLeft : .forceLeftToRight
        UIView.appearance().semanticContentAttribute = semanticContentAttribute
        
        // set current language
        currentLanguage = language
    }
    
    
    ///
    /// Set the current language of the app
    ///
    /// - parameter language: The language that you need the app to run with.
    /// - parameter windows: The windows you want to change the `rootViewController` for. if you didn't
    ///                      set it, it will change the `rootViewController` for all the windows in the
    ///                      scenes.
    /// - parameter viewControllerFactory: A closure to make the `ViewController` for a specific `scene`, you can know for which
    ///                                    `scene` you need to make the controller you can check the `title` sent to this clouser,
    ///                                    this title is the `title` of the `scene`, so if there is 5 scenes this closure will get called 5 times
    ///                                    for each scene window.
    /// - parameter animation: A closure with the current view to animate to the new view controller,
    ///                        so you need to animate the view, move it out of the screen, change the alpha,
    ///                        or scale it down to zero.
    ///
    public func setLanguage(language: Languages,
                            for windows: [WindowAndTitle]? = nil,
                            viewControllerFactory: ViewControllerFactory? = nil,
                            animation: Animation? = nil) {
        
        changeCurrentLanguageTo(language)
        
        guard let viewControllerFactory = viewControllerFactory else {
            return
        }
        
        let windowsToChange = getWindowsToChangeFrom(windows)
        
        windowsToChange?.forEach({ windowAndTitle in
            let (window, title) = windowAndTitle
            let viewController = viewControllerFactory(title)
            changeViewController(for: window,
                                 rootViewController: viewController,
                                 animation: animation)
        })
        
    }
    
    private func getWindowsToChangeFrom(_ windows: [WindowAndTitle]?) -> [WindowAndTitle]? {
        var windowsToChange: [WindowAndTitle]?
        if let windows = windows {
            windowsToChange = windows
        } else {
            windowsToChange = UIApplication.shared.connectedScenes
                .compactMap({$0 as? UIWindowScene})
                .map({ ($0.windows.first, $0.title) })
        }
        
        return windowsToChange
    }
    
    private func changeViewController(for window: UIWindow?,
                                      rootViewController: UIViewController,
                                      animation: Animation? = nil) {
        guard let snapshot = window?.snapshotView(afterScreenUpdates: true) else {
            return
        }
        rootViewController.view.addSubview(snapshot);
        
        window?.rootViewController = rootViewController
        
        UIView.animate(withDuration: 0.5, animations: {
            animation?(snapshot)
        }) { _ in
            snapshot.removeFromSuperview()
        }
    }
}
