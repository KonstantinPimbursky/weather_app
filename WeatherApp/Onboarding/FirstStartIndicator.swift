//
//  FirstStartIndicator.swift
//  WeatherApp
//
//  Created by Konstantin Pimbursky on 20.06.2021.
//

import Foundation

class FirstStartIndicator {
    
    static let shared = FirstStartIndicator()
    
    func isFirstStart() -> Bool {
        return !UserDefaults.standard.bool(forKey: "FirstStart")
    }
    
    func setNotFirstStart() {
        UserDefaults.standard.setValue(true, forKey: "FirstStart")
    }
}
