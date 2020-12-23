//
//  CarsListViewModel.swift
//  In-App-LanguageChange
//
//  Created by Milos Malovic on 22.12.20..
//

import Foundation


class CarsListViewModel {
    
    var cars: [Car]?
    
    init(cars: [Car]?) {
        self.cars = cars
    }
    
    var carsCount: Int {
        if let cars = cars {
            return cars.count
        } else {
            return 0
        }
    }
    
    func updateModel(cars: [Car]) {
        self.cars = cars
    }
    
    func createCarsCellModel(for index: Int) -> CarCellVieModel? {
        guard let cars = self.cars else { return nil }
        let model = CarCellVieModel(car: cars[index])
        return model
    }
}
