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
    func showMainViewController() -> Void
    func showSettingsScreen(updateCompletion: @escaping () -> Void) -> Void
    func showLocationChoice(completion: @escaping () -> Void)
    func showMoreForDaysViewController(location: String, dailyData: [DailyData]) -> Void
    func showMoreForHoursViewController(location: String, hourlyData: [HourlyData]) -> Void
    func createLocationViewController(with forecast: ForecastData) -> LocationViewController
    func createAddNewLocationViewController() -> AddNewLocationViewController
    func goBack() -> Void
}

class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    private let mainViewModel: MainViewModel
    private let locationViewModel: LocationViewModel
    private let networkService: NetworkProtocol
    
    init(navigationController: UINavigationController,
         networkService: NetworkProtocol,
         mainViewModel: MainViewModel,
         locationViewModel: LocationViewModel) {
        self.navigationController = navigationController
        self.networkService = networkService
        self.mainViewModel = mainViewModel
        self.locationViewModel = locationViewModel
    }
    
    func start() {
        if FirstStartIndicator.shared.isFirstStart() {
            UserDefaults.standard.setValue("C", forKey: "temperature")
            UserDefaults.standard.setValue("Km", forKey: "windSpeed")
            UserDefaults.standard.setValue("24", forKey: "dateFormat")
            UserDefaults.standard.setValue(true, forKey: "notifications")
            let onboardingViewController = OnboardingViewController(coordinator: self)
            navigationController.pushViewController(onboardingViewController, animated: false)
        } else {
            showMainViewController()
        }
    }
    
    func showMainViewController() {
        let mainViewController = MainViewController(coordinator: self, viewModel: mainViewModel)
        navigationController.pushViewController(mainViewController, animated: false)
    }
    
    func showSettingsScreen(updateCompletion: @escaping () -> Void) {
        let settingsViewController = SettingsViewController(saveComletion: updateCompletion)
        settingsViewController.modalPresentationStyle = .fullScreen
        settingsViewController.modalTransitionStyle = .crossDissolve
        navigationController.present(settingsViewController, animated: true)
    }
    
    func showLocationChoice(completion: @escaping () -> Void) {
        let alertController = UIAlertController(title: "?????????? ????????????????????????????",
                                                message: "?????????????? ???????????????? ?????????????????????? ????????????",
                                                preferredStyle: .alert)
        alertController.addTextField { field in
            field.placeholder = "???????????????????? ??????????"
        }
        let acceptAction = UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            guard let fields = alertController.textFields, fields.count == 1 else {
                return
            }
            guard let location = fields[0].text, !location.isEmpty else {
                return
            }
            self?.networkService.getCoordinatesFromCity(city: location, completion: { [weak self] geocodingModel in
                self?.mainViewModel.getForecastForNewLocation(for: geocodingModel, usingGeolocation: false, completion: completion)
            })
        })
        let cancelAction = UIAlertAction(title: "????????????", style: .cancel, handler: nil)
        alertController.addAction(acceptAction)
        alertController.addAction(cancelAction)
        
        navigationController.present(alertController, animated: true, completion: nil)
    }
    
    func showMoreForDaysViewController(location: String, dailyData: [DailyData]) {
        let moreForeDaysViewController = MoreForDaysViewController(location: location, dailyData: dailyData, coordinator: self)
        navigationController.pushViewController(moreForeDaysViewController, animated: true)
    }
    
    func showMoreForHoursViewController(location: String, hourlyData: [HourlyData]) {
        let moreForHoursViewController = MoreForHoursViewController(location: location,
                                                                    hourlyData: hourlyData,
                                                                    coordinator: self)
        navigationController.pushViewController(moreForHoursViewController, animated: true)
    }
    
    func createLocationViewController(with forecast: ForecastData) -> LocationViewController {
        let locationViewController = LocationViewController(coordinator: self,
                                                            viewModel: locationViewModel,
                                                            forecast: forecast)
        return locationViewController
    }
    
    func createAddNewLocationViewController() -> AddNewLocationViewController {
        let addNewLocationViewController = AddNewLocationViewController(coordinator: self)
        return addNewLocationViewController
    }
    
    func goBack() {
        navigationController.popViewController(animated: true)
    }
    
}
