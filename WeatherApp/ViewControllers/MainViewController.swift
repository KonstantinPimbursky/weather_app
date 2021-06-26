//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Konstantin Pimbursky on 20.06.2021.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    // MARK: - PROPERTIES
    private let coordinator: Coordinator
    private var viewModel: MainOutput
    private var city: String? {
        didSet {
            self.locationLabel.text = city
        }
    }
    
    private let settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "settings"), for: .normal)
        button.tintColor = UIColor(named: "myBlack")
        button.addTarget(self, action: #selector(settingButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Location..."
        label.font = UIFont(name: "Rubik-Medium", size: 18)
        label.textColor = UIColor(named: "myBlack")
        return label
    }()
    
    private let locationChoiceButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "location"), for: .normal)
        button.tintColor = UIColor(named: "myBlack")
        button.addTarget(self, action: #selector(locationButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - INIT
    init(coordinator: Coordinator,
         viewModel: MainOutput) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        viewModel.getCityFromCoordinates(completion: { [weak self] city in
                self?.city = city
                print(city)
        })
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        coordinator.showOnborading()
    }
    
    private func setupViews() {
        view.addSubview(settingsButton)
        view.addSubview(locationLabel)
        view.addSubview(locationChoiceButton)
        
        settingsButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(43)
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(18)
            make.width.equalTo(34)
        }
        
        locationLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(41)
            make.centerX.equalToSuperview()
        }
        
        locationChoiceButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(37)
            make.right.equalToSuperview().offset(-15)
            make.width.equalTo(20)
            make.height.equalTo(26)
        }
    }
    
    @objc private func settingButtonTapped() {
        coordinator.showSettingsScreen()
    }
    
    @objc private func locationButtonTapped() {
        coordinator.showLocationChoice()
    }
    
}
