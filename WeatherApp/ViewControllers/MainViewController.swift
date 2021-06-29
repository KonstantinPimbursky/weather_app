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
    private var forecast: ForecastData?
    
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
    
    private let currentForecastView: UIView = {
        let someView = UIView()
        someView.backgroundColor = UIColor(named: "mainBlue")
        someView.layer.cornerRadius = 5
        return someView
    }()
    
    private let sunEllipseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ellipse")
        return imageView
    }()
    
    private let sunriseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sunrise")
        imageView.tintColor = UIColor(named: "myYellow")
        return imageView
    }()
    
    private let minMaxTemperatureLabel: UILabel = {
        let label = UILabel()
        // "\u{00B0}" - значок градуса
        label.text = "--/--"
        label.textColor = UIColor.white
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        return label
    }()
    
    private let currentTemperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.textColor = UIColor.white
        label.font = UIFont(name: "Rubik-Regular", size: 36)
        return label
    }()
    
    private let currentWeatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.textColor = UIColor.white
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        return label
    }()
    
    private let windSpeedLabel: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.textColor = UIColor.white
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        return label
    }()
    
    // MARK: - INIT
    init(coordinator: Coordinator,
         viewModel: MainOutput) {
        self.coordinator = coordinator
        self.viewModel = viewModel
//        self.forecast = viewModel.getForecast()
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
        view.addSubview(currentForecastView)
        
        currentForecastView.addSubview(sunEllipseImageView)
        currentForecastView.addSubview(minMaxTemperatureLabel)
        currentForecastView.addSubview(currentTemperatureLabel)
        currentForecastView.addSubview(currentWeatherDescriptionLabel)
        currentForecastView.addSubview(sunriseImageView)
        
        settingsButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(43)
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(18)
            make.width.equalTo(34)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(41)
            make.centerX.equalToSuperview()
        }
        
        locationChoiceButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(37)
            make.right.equalToSuperview().offset(-15)
            make.width.equalTo(20)
            make.height.equalTo(26)
        }
        
        currentForecastView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(112)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-15)
        }
        
        sunEllipseImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17)
            make.left.equalToSuperview().offset(33)
            make.right.equalToSuperview().offset(-31)
        }
        
        sunriseImageView.snp.makeConstraints { make in
            make.width.equalTo(sunriseImageView.snp.height)
            make.top.equalToSuperview().offset(145)
            make.left.equalToSuperview().offset(25)
            make.bottom.equalToSuperview().offset(-50)
        }
        
        minMaxTemperatureLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(33)
            make.centerX.equalToSuperview()
        }
        
        currentTemperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(minMaxTemperatureLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        
        currentWeatherDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(currentTemperatureLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc private func settingButtonTapped() {
        coordinator.showSettingsScreen()
    }
    
    @objc private func locationButtonTapped() {
        coordinator.showLocationChoice()
    }
    
}
