//
//  HourlyCollectionViewCell.swift
//  WeatherApp
//
//  Created by Konstantin Pimbursky on 09.07.2021.
//

import UIKit

class HourlyForecastCollectionViewCell: UICollectionViewCell {
    
    // MARK: -PROPERTIES
    var hourlyForacast: HourlyData? {
        didSet {
            let timeformatter = DateFormatter()
            if timeSettings == "12" {
                timeformatter.dateFormat = "HH:mm"
            } else {
                timeformatter.dateFormat = "hh:mm"
            }
            
            if let hourly = hourlyForacast {
                let date = Date(timeIntervalSince1970: hourly.dt)
                timeLabel.text = timeformatter.string(from: date)
                forecastIconImageView.image = UIImage(named: hourly.weather.icon)
                temperatureLabel.text = "\(Int(hourly.temp))\u{00B0}"
            }
        }
    }
    
    private var timeSettings: String {
        get {
            return UserDefaults.standard.string(forKey: "dateFormat")!
        }
    }
    
    private let forecastContentVIew: UIView = {
        let someView = UIView()
        someView.layer.cornerRadius = 22
        someView.layer.borderWidth = 0.5
        someView.layer.borderColor = UIColor(red: 171/255,
                                             green: 188/255,
                                             blue: 234/255,
                                             alpha: 1.0).cgColor
        return someView
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 12)
        label.textColor = UIColor(red: 0.613,
                                  green: 0.592,
                                  blue: 0.592,
                                  alpha: 1.0)
        return label
    }()
    
    private let forecastIconImageView = UIImageView()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor = .black
        return label
    }()
    
    // MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(forecastContentVIew)
        forecastContentVIew.addSubview(timeLabel)
        forecastContentVIew.addSubview(forecastIconImageView)
        forecastContentVIew.addSubview(temperatureLabel)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - FUNCTIONS
    private func setupViews() {
            
        forecastContentVIew.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
            make.width.equalTo(42)
            make.height.equalTo(83)
        }
        
        forecastIconImageView.snp.makeConstraints { make in
            make.height.width.equalTo(20)
            make.center.equalToSuperview()
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.height.equalTo(18)
            make.centerX.equalToSuperview()
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(forecastIconImageView.snp.bottom).offset(5)
            make.height.equalTo(18)
            make.centerX.equalToSuperview()
        }
    }
    
    func showSelected() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 63/255, green: 101/255, blue: 206/255, alpha: 0.58).cgColor,
            UIColor(red: 32/255, green: 78/255, blue: 199/255, alpha: 1).cgColor
        ]
        gradientLayer.frame = self.contentView.bounds
        gradientLayer.cornerRadius = 22
        self.layer.insertSublayer(gradientLayer, at: 0)
        self.layer.shadowColor = UIColor(red: 0.4, green: 0.55, blue: 0.94, alpha: 0.68).cgColor
        self.layer.shadowRadius = 45
        self.layer.shadowOffset = CGSize(width: -5, height: 5)
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        timeLabel.textColor = .white
        temperatureLabel.textColor = .white
    }
}
