//
//  CarCollectionViewCell.swift
//  In-App-LanguageChange
//
//  Created by Milos Malovic on 22.12.20..
//

import UIKit

class CarCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var carNameLabel: UILabel!
    @IBOutlet weak var userReviewLabel: UILabel!
    @IBOutlet weak var availabilityLbl: UILabel!
    @IBOutlet weak var infoBtn: UIButton!
    @IBOutlet weak var designView: UIView!
    
    var model: CarCellVieModel? {
        didSet {
            carImageView.image = UIImage(named: "\(model?.imageName ?? "")")
            carNameLabel.text = model?.carName
            userReviewLabel.text = model?.userReview
            availabilityLbl.text = model?.availability
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        designView.layer.borderColor = borderColor.cgColor
    }
    
    var borderColor: UIColor {
        if traitCollection.userInterfaceStyle == .dark {
            return UIColor.systemGray4
        } else {
            return UIColor.lightGray
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        setDetails()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setDetails() {
        designView.layer.borderWidth = 1
        designView.layer.borderColor = borderColor.cgColor
    }
}
