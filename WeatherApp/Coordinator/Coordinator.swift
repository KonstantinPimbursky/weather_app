//
//  Coordinator.swift
//  WeatherApp
//
//  Created by Konstantin Pimbursky on 21.06.2021.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    
    func start()
    func showOnborading()
    func showSettingsScreen()
    func showLocationChoice()
}

