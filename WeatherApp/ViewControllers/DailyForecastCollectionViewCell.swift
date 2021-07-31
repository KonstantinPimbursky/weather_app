//
//  DailyForecastCollectionViewCell.swift
//  WeatherApp
//
//  Created by Konstantin Pimbursky on 27.07.2021.
//

import UIKit
import SnapKit

class DailyForecastCollectionViewCell: UICollectionViewCell {
    
    // MARK: - PROPERTIES
    var dailyForecast: DailyData? {
        didSet {
            fillLabels()
        }
    }
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor = UIColor(red: 0.6, green: 0.59, blue: 0.59, alpha: 1.0)
        return label
    }()
    
    private let weatherIconImageView = UIImageView()
    
    private let humidityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 12)
        label.textColor = UIColor(red: 0.13, green: 0.31, blue: 0.78, alpha: 1.0)
        return label
    }()
    
    private let weatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor = UIColor(red: 0.15, green: 0.15, blue: 0.13, alpha: 1.0)
        label.numberOfLines = 0
        return label
    }()
    
    private let minMaxTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Rubik-Regular", size: 18)
        label.textColor = UIColor.black
        return label
    }()
    
    private let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = UIColor.black
        return imageView
    }()
    
    
    // MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - FUNCTIONS
    private func fillLabels() {
        guard let dailyData = dailyForecast else {
            return
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM"
        let date = Date(timeIntervalSince1970: dailyData.dt)
        dateLabel.text = formatter.string(from: date)
        weatherIconImageView.image = UIImage(named: dailyData.weather.icon)
        humidityLabel.text = "\(dailyData.humidity)%"
        weatherDescriptionLabel.text = dailyData.weather.weatherDescription.capitalizingFirstLetter()
        minMaxTemperatureLabel.text = "\(Int(dailyData.temp.min))\u{00B0}/\(Int(dailyData.temp.max))\u{00B0}"
    }
    
    private func setupViews() {
        contentView.backgroundColor = UIColor(red: 0.91, green: 0.93, blue: 0.98, alpha: 1.0)
        contentView.layer.cornerRadius = 5
        
        contentView.addSubview(dateLabel)
        contentView.addSubview(weatherIconImageView)
        contentView.addSubview(humidityLabel)
        contentView.addSubview(weatherDescriptionLabel)
        contentView.addSubview(minMaxTemperatureLabel)
        contentView.addSubview(chevronImageView)
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6)
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(19)
        }
        
        weatherIconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-9)
            make.width.equalTo(weatherIconImageView.snp.height)
        }
        
        humidityLabel.snp.makeConstraints { make in
            make.centerY.equalTo(weatherIconImageView)
            make.left.equalTo(weatherIconImageView.snp.right).offset(5)
        }
        
        weatherDescriptionLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(66)
            make.right.equalToSuperview().offset(-72)
        }
        
        minMaxTemperatureLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-26)
        }
        
        chevronImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(6)
        }
    }
}
