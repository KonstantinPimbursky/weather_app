//
//  MainCoordinator.swift
//  WeatherApp
//
//  Created by Konstantin Pimbursky on 21.06.2021.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let mainViewController = MainViewController(coordinator: self)
        navigationController.pushViewController(mainViewController, animated: false)
    }
    
    func showOnborading() {
        if FirstStartIndicator.shared.isFirstStart() {
            let onboardingViewController = OnboardingViewController()
            onboardingViewController.modalPresentationStyle = .fullScreen
            navigationController.present(onboardingViewController, animated: true, completion: nil)
        }
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
