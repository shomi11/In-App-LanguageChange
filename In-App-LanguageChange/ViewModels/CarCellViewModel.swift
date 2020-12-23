//
//  CarCellViewModel.swift
//  In-App-LanguageChange
//
//  Created by Milos Malovic on 22.12.20..
//

import Foundation

class  CarCellVieModel {
    let car: Car?
    
    init(car: Car) {
        self.car = car
    }
    
    var imageName: String {
        return car?.image ?? ""
    }
    
    var carName: String {
        return car?.name ?? ""
    }
    
    var horsePower: String {
        return "\(car?.horsePower ?? 0.0)"
    }
    
    var availability: String {
        return "From \(car?.availability ?? "")"
    }
    
    var userReview: String {
        return "\(car?.userReview ?? 0.0)"
    }
}
