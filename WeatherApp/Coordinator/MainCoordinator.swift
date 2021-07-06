//
//  MainCoordinator.swift
//  WeatherApp
//
//  Created by Konstantin Pimbursky on 21.06.2021.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    
    func start() -> Void
    func showSettingsScreen() -> Void
    func showLocationChoice() -> Void
}

class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var mainViewModel: MainViewModel
    
    init(navigationController: UINavigationController,
         mainViewModel: MainViewModel) {
        self.navigationController = navigationController
        self.mainViewModel = mainViewModel
    }
    
    func start() {
        let mainViewController = MainViewController(coordinator: self, viewModel: mainViewModel)
        navigationController.pushViewController(mainViewController, animated: false)
    }
    
    func showSettingsScreen() {
        let settingsViewController = SettingsViewController()
        settingsViewController.modalPresentationStyle = .fullScreen
        settingsViewController.modalTransitionStyle = .crossDissolve
        navigationController.present(settingsViewController, animated: true)
    }
    
    func showLocationChoice() {
        
    }
    
}
