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
    private var forecast: ForecastData? {
        didSet {
            self.fillLabels()
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
        return imageView
    }()
    
    private let sunsetImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sunset")
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
    
    private let sunriseTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "--:--"
        label.textColor = UIColor.white
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        return label
    }()
    
    private let sunsetTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "--:--"
        label.textColor = UIColor.white
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        return label
    }()
    
    private let rainfallImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "02d")
        return imageView
    }()
    
    private let windImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "wind")
        return imageView
    }()
    
    private let humidityImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "humidity")
        return imageView
    }()
    
    private let rainfallLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = UIColor.white
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        return label
    }()
    
    private let windSpeedLabel: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.textColor = UIColor.white
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        return label
    }()
    
    private let humidityLabel: UILabel = {
        let label = UILabel()
        label.text = "--"
        label.textColor = UIColor.white
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        return label
    }()
    
    private let contentView = UIView()
    
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
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if FirstStartIndicator.shared.isFirstStart() {
            let onboardingViewController = OnboardingViewController {
                self.viewModel.getLocation { city in
                    self.locationLabel.text = city
                }
                self.viewModel.getForecast { forecast in
                    self.forecast = forecast
                }
            }
            present(onboardingViewController, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !FirstStartIndicator.shared.isFirstStart() {
            viewModel.getLocation { city in
                self.locationLabel.text = city
            }
            viewModel.getForecast(completion: { forecast in
                self.forecast = forecast
            })
        }
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
        currentForecastView.addSubview(sunriseTimeLabel)
        currentForecastView.addSubview(sunsetImageView)
        currentForecastView.addSubview(sunsetTimeLabel)
        currentForecastView.addSubview(contentView)
        
        contentView.addSubview(rainfallImageView)
        contentView.addSubview(rainfallLabel)
        contentView.addSubview(windImageView)
        contentView.addSubview(windSpeedLabel)
        contentView.addSubview(humidityImageView)
        contentView.addSubview(humidityLabel)
        
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
        
        sunsetImageView.snp.makeConstraints { make in
            make.width.equalTo(sunriseImageView.snp.height)
            make.top.equalToSuperview().offset(145)
            make.right.equalToSuperview().offset(-25)
            make.bottom.equalToSuperview().offset(-50)
        }
        
        sunriseTimeLabel.snp.makeConstraints { make in
            make.centerX.equalTo(sunriseImageView.snp.centerX)
            make.bottom.equalToSuperview().offset(-26)
        }
        
        sunsetTimeLabel.snp.makeConstraints { make in
            make.centerX.equalTo(sunsetImageView.snp.centerX)
            make.bottom.equalToSuperview().offset(-26)
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
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(currentWeatherDescriptionLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        rainfallImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(7)
            make.left.equalToSuperview()
            make.bottom.equalToSuperview().offset(-5)
        }
        
        rainfallLabel.snp.makeConstraints { make in
            make.centerY.equalTo(rainfallImageView)
            make.left.equalTo(rainfallImageView.snp.right).offset(5)
        }
        
        windImageView.snp.makeConstraints { make in
            make.centerY.equalTo(rainfallImageView)
            make.left.equalTo(rainfallLabel.snp.right).offset(20)
        }
        
        windSpeedLabel.snp.makeConstraints { make in
            make.centerY.equalTo(windImageView)
            make.left.equalTo(windImageView.snp.right).offset(5)
        }
        
        humidityImageView.snp.makeConstraints { make in
            make.centerY.equalTo(windSpeedLabel)
            make.left.equalTo(windSpeedLabel.snp.right).offset(20)
        }
        
        humidityLabel.snp.makeConstraints { make in
            make.centerY.equalTo(humidityImageView)
            make.left.equalTo(humidityImageView.snp.right).offset(5)
            make.right.equalToSuperview()
        }
    }
    
    @objc private func settingButtonTapped() {
        coordinator.showSettingsScreen()
    }
    
    @objc private func locationButtonTapped() {
        coordinator.showLocationChoice()
    }
    
    private func fillLabels() {
        guard forecast != nil else {
            return
        }
        let dailyForecast = forecast!.daily as! Set<DailyData>
        let currentWeather = forecast!.current.weather as! Set<WeatherData>
        for day in dailyForecast {
            let currentDay = Calendar.current.component(.day, from: Date(timeIntervalSince1970: day.dt))
            let today = Calendar.current.component(.day, from: Date())
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm"
            let sunrise = timeFormatter.string(from: Date(timeIntervalSince1970: day.sunrise))
            let sunset = timeFormatter.string(from: Date(timeIntervalSince1970: day.sunset))
            if currentDay == today {
                minMaxTemperatureLabel.text = "\(Int(day.temp.min))\u{00B0}/\(Int(day.temp.max))\u{00B0}"
                sunriseTimeLabel.text = sunrise
                sunsetTimeLabel.text = sunset
                break
            }
        }
        for weather in currentWeather {
            currentWeatherDescriptionLabel.text = "\(weather.weatherDescription)"
            currentWeatherDescriptionLabel.text?.capitalizeFirstLetter()
        }
        currentTemperatureLabel.text = "\(Int(forecast!.current.temp))\u{00B0}"
        if forecast!.current.rain?.oneHour != nil {
            self.rainfallLabel.text = forecast!.current.rain!.oneHour + " мм"
        }
        windSpeedLabel.text = "\(forecast!.current.windSpeed) м\\c"
        
    }
    
}

extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}
