//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Konstantin Pimbursky on 20.06.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - PROPERTIES
    private let locationManager: LocationManager
    
    // MARK: - INIT
    init(with locationManager: LocationManager) {
        self.locationManager = locationManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if FirstStartIndicator.shared.isFirstStart() {
            let onboardingViewController = OnboardingViewController(locationManager: locationManager)
            onboardingViewController.modalPresentationStyle = .fullScreen
            present(onboardingViewController, animated: true, completion: nil)
        }
    }
    
}
