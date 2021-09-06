//
//  LocationViewController.swift
//  WeatherApp
//
//  Created by Konstantin Pimbursky on 11.07.2021.
//

import UIKit

class LocationViewController: UIViewController {
    
    // MARK: - PROPERTIES
    private let coordinator: Coordinator
    private let viewModel: LocationOutput
    private var forecast: ForecastData
    private var updatedFlag = false
    
    private var currentForecast: CurrentData? {
        didSet {
            viewModel.getHourlyData(for: forecast) { [weak self] hourlyData in
                self?.hourlyForecast = hourlyData
            }
        }
    }
    private var hourlyForecast: [HourlyData]? {
        didSet {
            viewModel.getDailyData(for: forecast) { [weak self] dailyData in
                self?.dailyForecast = dailyData
            }
        }
    }
    private var dailyForecast: [DailyData]? {
        didSet {
            guard dailyForecast != nil else {
                return
            }
            if !updatedFlag {
                updatedFlag = true
                fillLabels()
                setupViews()
                setupHourlyCollectionView()
                setupDailyColletionView()
                updateForecastData()
            } else {
                fillLabels()
                hourlyForecastColletionView.reloadData()
                dailyForecastColletionView.reloadData()
            }
        }
    }
    
    private var timer = Timer()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Location..."
        label.font = UIFont(name: "Rubik-Medium", size: 18)
        label.textColor = UIColor(named: "myBlack")
        return label
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
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let sunsetImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sunset")
        imageView.contentMode = .scaleAspectFill
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
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let windImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "wind")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let humidityImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "humidity")
        imageView.contentMode = .scaleAspectFill
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
    
    private let rainfallWindSpeedHumidityContentView = UIView()
    
    private let currentTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "myYellow")
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        return label
    }()
    
    private let moreForDayButton: UIButton = {
        let button = UIButton()
        let atributedString = NSMutableAttributedString(string: "Подробнее на 24 часа")
        atributedString.addAttribute(.underlineStyle,
                                     value: NSNumber(value: 1),
                                     range: NSRange(location: 0, length: atributedString.length))
        atributedString.addAttribute(.font,
                                     value: UIFont(name: "Rubik-Regular", size: 16)!,
                                     range: NSRange(location: 0, length: atributedString.length))
        atributedString.addAttribute(.foregroundColor,
                                     value: UIColor.black,
                                     range: NSRange(location: 0, length: atributedString.length))
        button.setAttributedTitle(atributedString, for: .normal)
        button.addTarget(self, action: #selector(moreForDayButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let hourlyForecastColletionView: UICollectionView = {
        let celSize = CGSize(width: 42, height: 83)
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .horizontal
        layout.itemSize = celSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let dailyForecastLabel: UILabel = {
        let label = UILabel()
        label.text = "Ежедневный прогноз"
        label.textColor = UIColor(red: 0.15, green: 0.15, blue: 0.13, alpha: 1.0)
        label.font = UIFont(name: "Rubik-Regular", size: 18)
        return label
    }()
    
    private let dailyForecastColletionView: UICollectionView = {
        let celSize = CGSize(width: UIScreen.main.bounds.width - 16*2, height: 56)
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        layout.itemSize = celSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    // MARK: - INIT
    init(coordinator: Coordinator,
         viewModel: LocationOutput,
         forecast: ForecastData) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        self.forecast = forecast
        super.init(nibName: nil, bundle: nil)
        self.viewModel.getCurrentData(for: forecast) { [weak self] currentData in
            self?.currentForecast = currentData
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(tick),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc private func tick() {
        let timeformatter = DateFormatter()
        if UserDefaults.standard.string(forKey: "dateFormat") == "12" {
            timeformatter.dateFormat = "hh:mm"
        } else {
            timeformatter.dateFormat = "HH:mm"
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEEEE dd MMMM"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        let currentDate = dateFormatter.string(from: Date())
        let currentTime = timeformatter.string(from: Date())
        currentTimeLabel.text = "\(currentTime), \(currentDate)"
    }
    
    @objc private func moreForDayButtonTapped() {
        
    }
    
    private func updateForecastData() {
        viewModel.updateForecast(forecast: forecast) { [weak self] forecastData in
            self?.viewModel.getCurrentData(for: forecastData) { [weak self] currentData in
                self?.currentForecast = currentData
            }
        }
    }
    
    private func setupHourlyCollectionView() {
        hourlyForecastColletionView.backgroundColor = view.backgroundColor
        hourlyForecastColletionView.delegate = self
        hourlyForecastColletionView.dataSource = self
        hourlyForecastColletionView.register(HourlyForecastCollectionViewCell.self,
                                     forCellWithReuseIdentifier: "HourlyCell")
        view.addSubview(hourlyForecastColletionView)
        
        hourlyForecastColletionView.snp.makeConstraints { make in
            make.top.equalTo(moreForDayButton.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(83)
        }
    }
    
    private func setupDailyColletionView() {
        dailyForecastColletionView.backgroundColor = view.backgroundColor
        dailyForecastColletionView.delegate = self
        dailyForecastColletionView.dataSource = self
        dailyForecastColletionView.register(DailyForecastCollectionViewCell.self,
                                            forCellWithReuseIdentifier: "DailyCell")
        view.addSubview(dailyForecastLabel)
        view.addSubview(dailyForecastColletionView)
        
        dailyForecastLabel.snp.makeConstraints { make in
            make.top.equalTo(hourlyForecastColletionView.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(16)
        }
        
        dailyForecastColletionView.snp.makeConstraints { make in
            make.top.equalTo(dailyForecastLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(20)
        }
    }
    
    private func setupViews() {
        view.addSubview(locationLabel)
        view.addSubview(currentForecastView)
        view.addSubview(moreForDayButton)
        
        currentForecastView.addSubview(sunEllipseImageView)
        currentForecastView.addSubview(minMaxTemperatureLabel)
        currentForecastView.addSubview(currentTemperatureLabel)
        currentForecastView.addSubview(currentWeatherDescriptionLabel)
        currentForecastView.addSubview(sunriseImageView)
        currentForecastView.addSubview(sunriseTimeLabel)
        currentForecastView.addSubview(sunsetImageView)
        currentForecastView.addSubview(sunsetTimeLabel)
        currentForecastView.addSubview(rainfallWindSpeedHumidityContentView)
        currentForecastView.addSubview(currentTimeLabel)
        
        rainfallWindSpeedHumidityContentView.addSubview(rainfallImageView)
        rainfallWindSpeedHumidityContentView.addSubview(rainfallLabel)
        rainfallWindSpeedHumidityContentView.addSubview(windImageView)
        rainfallWindSpeedHumidityContentView.addSubview(windSpeedLabel)
        rainfallWindSpeedHumidityContentView.addSubview(humidityImageView)
        rainfallWindSpeedHumidityContentView.addSubview(humidityLabel)
        
        locationLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(41)
            make.centerX.equalToSuperview()
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
            make.height.equalTo(20)
        }
        
        currentTemperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(minMaxTemperatureLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
        currentWeatherDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(currentTemperatureLabel.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }
        
        rainfallWindSpeedHumidityContentView.snp.makeConstraints { make in
            make.top.equalTo(currentWeatherDescriptionLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
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
        
        currentTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(rainfallWindSpeedHumidityContentView.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-21)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }
        
        moreForDayButton.snp.makeConstraints { make in
            make.top.equalTo(currentForecastView.snp.bottom).offset(33)
            make.right.equalToSuperview().offset(-15)
        }
    }
    
    private func fillLabels() {
        let timeFormatter = DateFormatter()
        if UserDefaults.standard.string(forKey: "dateFormat") == "24" {
            timeFormatter.dateFormat = "HH:mm"
        } else {
            timeFormatter.dateFormat = "hh:mm"
        }
        let sunrise = timeFormatter.string(from: Date(timeIntervalSince1970: dailyForecast![0].sunrise))
        let sunset = timeFormatter.string(from: Date(timeIntervalSince1970: dailyForecast![0].sunset))
        locationLabel.text = forecast.location
        minMaxTemperatureLabel.text = "\(Int(dailyForecast![0].temp.min))\u{00B0}/\(Int(dailyForecast![0].temp.max))\u{00B0}"
        sunriseTimeLabel.text = sunrise
        sunsetTimeLabel.text = sunset
        humidityLabel.text = "\(dailyForecast![0].humidity)%"
        currentWeatherDescriptionLabel.text = currentForecast!.weather.weatherDescription
        currentWeatherDescriptionLabel.text?.capitalizeFirstLetter()
        currentTemperatureLabel.text = "\(Int(currentForecast!.temp))\u{00B0}"
        if dailyForecast![0].rain != 0 {
            rainfallLabel.text = "\(dailyForecast![0].rain) мм"
        } else {
            if dailyForecast![0].snow != 0 {
                rainfallLabel.text = "\(dailyForecast![0].snow) мм"
            } else {
                rainfallLabel.text = "0 мм"
            }
        }
        if UserDefaults.standard.string(forKey: "windSpeed") == "Km" {
            windSpeedLabel.text = "\(currentForecast!.windSpeed) м\\c"
        } else {
            let windSpeed = Double(currentForecast!.windSpeed) * 2.237
            windSpeedLabel.text = "\(windSpeed) миля\\ч"
        }
    }
}

extension LocationViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == hourlyForecastColletionView {
            return hourlyForecast!.count
        } else {
            return dailyForecast!.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == hourlyForecastColletionView {
            let cell: HourlyForecastCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyCell", for: indexPath) as! HourlyForecastCollectionViewCell
            cell.hourlyForacast = hourlyForecast![indexPath.item]
            return cell
        } else {
            let cell: DailyForecastCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DailyCell", for: indexPath) as! DailyForecastCollectionViewCell
            cell.dailyForecast = dailyForecast![indexPath.item]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == hourlyForecastColletionView {
            let cell = collectionView.cellForItem(at: indexPath) as! HourlyForecastCollectionViewCell
            cell.showSelected()
        } else {
            self.coordinator.showMoreForDaysViewController(location: locationLabel.text!, dailyData: dailyForecast!)
        }
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
