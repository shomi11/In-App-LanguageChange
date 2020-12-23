//
//  Car.swift
//  In-App-LanguageChange
//
//  Created by Milos Malovic on 20.12.20..
//

import UIKit
import Foundation

struct Car: Codable {
    let name: String
    let horsePower: Double
    var image: String
    var availability: String
    var userReview: Double

    static func example() -> [Car] {
        let car1 = Car(name: "M5", horsePower: 551, image: "m5", availability: "2.9.2021", userReview: 7.5)
        let car2 = Car( name: "911 turbo s", horsePower: 551, image: "911", availability: "23.4.2021", userReview: 9.0)
        let car3 = Car(name: "Aventador", horsePower: 551, image: "aventador", availability: "1.8.2021", userReview: 8.2)
        let car4 = Car(name: "Golf R 7.5", horsePower: 551, image: "GolfR", availability: "12.6.2021", userReview: 7.9)
        let car5 = Car(name: "A45's", horsePower: 551, image: "a45", availability: "3.3.2021", userReview: 8.7)
        let cars = [car1, car2, car3, car4, car5]
        return cars
    }
}
