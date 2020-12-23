//
//  AuthetificationViewController.swift
//  In-App-LanguageChange
//
//  Created by Milos Malovic on 20.12.20..
//

import UIKit

fileprivate let passExample = "mmdev"
fileprivate let emailExample = "example@email.com"

class AuthetificationViewController: UIViewController {

    @IBOutlet weak var emailTxtField: PaddingTextField!
    @IBOutlet weak var passwordTxtField: PaddingTextField!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var txtFieldsStackView: UIStackView!
    @IBOutlet weak var txtFieldsView: UIView!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var animCarImageView: UIImageView!
    @IBOutlet weak var animRightConstraint: NSLayoutConstraint!
    @IBOutlet weak var switchLanguageControll: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialUI()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        txtFieldsView.backgroundColor = UIColor.systemGray3.withAlphaComponent(0.5)
    }
    
    private func setInitialUI() {
        if LanguageManager.shared.currentLanguage == .es {
            switchLanguageControll.selectedSegmentIndex = 1
        }
        
        txtFieldsView.layer.cornerRadius = 10
        
        txtFieldsView.backgroundColor = UIColor.systemGray3.withAlphaComponent(0.5)
        signInBtn.layer.cornerRadius = 22
        self.bgImageView.blur(0.6)
    }
  
    @IBAction func signInBtnPressed(_ sender: Any) {
        guard let email = emailTxtField.text?.trimmingCharacters(in: .whitespaces), email == emailExample else { return }
        guard let password = passwordTxtField.text?.trimmingCharacters(in: .whitespaces), password == passExample else { return }
        successSignInAnimation()
    }
    
    @IBAction func swichLanguageTapped(_ sender: UISegmentedControl) {
        ChangeLanguage.shared.changeLanguage(sender: sender)
    }
    
    private func successSignInAnimation() {
        UIView.animate(withDuration: 3, delay: 0.1, options: .curveEaseOut) {
            self.signInBtn.isHidden = true
            self.animCarImageView.alpha = 1
            self.animRightConstraint.priority = .defaultHigh
            self.view.layoutIfNeeded()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let storyboard = UIStoryboard(name: "Cars", bundle: nil)
                guard let vc = storyboard.instantiateViewController(identifier: "SuperCarsCollectionViewController") as? SuperCarsCollectionViewController else { return }
                vc.viewModel = CarsListViewModel(cars: Car.example())
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } 
    }
}
