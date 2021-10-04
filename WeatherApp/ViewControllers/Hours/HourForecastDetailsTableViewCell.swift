//
//  HourForecastDetailsTableViewCell.swift
//  WeatherApp
//
//  Created by Konstantin Pimbursky on 12.09.2021.
//

import UIKit

class HourForecastDetailsTableViewCell: UITableViewCell {

    // MARK: - PROPERTIES
    var oneHourData: HourlyData? {
        didSet {
            fillLabels()
        }
    }
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "MyBlack")
        label.font = UIFont(name: "Rubik-Regular", size: 18)
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.604, green: 0.587, blue: 0.587, alpha: 1)
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "MyBlack")
        label.font = UIFont(name: "Rubik-Regular", size: 18)
        return label
    }()
    
    private let weatherDescriptionIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "moon_2")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let weatherDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "MyBlack")
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private let feelsLikeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "MyBlack")
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textAlignment = .right
        return label
    }()
    
    private let windSpeedIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "wind")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let windSpeedTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "MyBlack")
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.text = "Ветер"
        return label
    }()
    
    private let windSpeedLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.604, green: 0.587, blue: 0.587, alpha: 1)
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        return label
    }()
    
    private let precipitationIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pop")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let precipitationTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "MyBlack")
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.text = "Атмосферные осадки"
        return label
    }()
    
    private let precipitationLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.604, green: 0.587, blue: 0.587, alpha: 1)
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        return label
    }()
    
    private let cloudsIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "03d")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let cloudsTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "MyBlack")
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.text = "Облачность"
        return label
    }()
    
    private let cloudsLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.604, green: 0.587, blue: 0.587, alpha: 1)
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        return label
    }()
    
    private let lineView: UIView = {
        let someView = UIView()
        someView.backgroundColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        return someView
    }()
    
    // MARK: - INIT
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - FUNCTIONS
    private func setupSubviews() {
        contentView.addSubviews(dateLabel, timeLabel, temperatureLabel,
                                weatherDescriptionIcon, weatherDescriptionLabel, feelsLikeLabel,
                                windSpeedIcon, windSpeedTitleLabel, windSpeedLabel,
                                precipitationIcon, precipitationTitleLabel, precipitationLabel,
                                cloudsIcon, cloudsTitleLabel, cloudsLabel, lineView)
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.equalToSuperview().offset(16)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(19)
        }
        
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(10)
            make.centerX.equalTo(timeLabel.snp.centerX)
            make.height.equalTo(22)
        }
        
        weatherDescriptionIcon.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(11)
            make.left.equalTo(timeLabel.snp.right).offset(11)
            make.height.width.equalTo(14)
        }
        
        feelsLikeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(weatherDescriptionIcon)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(19)
        }
        
        weatherDescriptionLabel.snp.makeConstraints { make in
            make.centerY.equalTo(weatherDescriptionIcon)
            make.left.equalTo(weatherDescriptionIcon.snp.right).offset(4)
            make.right.equalTo(feelsLikeLabel.snp.left).offset(-4)
            make.height.equalTo(19)
        }
        
        windSpeedTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(weatherDescriptionLabel)
            make.top.equalTo(weatherDescriptionLabel.snp.bottom).offset(8)
            make.height.equalTo(19)
        }
        
        windSpeedIcon.snp.makeConstraints { make in
            make.centerY.equalTo(windSpeedTitleLabel)
            make.right.equalTo(windSpeedTitleLabel.snp.left).offset(-4)
            make.height.width.equalTo(14)
        }
        
        windSpeedLabel.snp.makeConstraints { make in
            make.centerY.equalTo(windSpeedTitleLabel)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(19)
        }
        
        precipitationTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(windSpeedTitleLabel)
            make.top.equalTo(windSpeedTitleLabel.snp.bottom).offset(8)
            make.height.equalTo(19)
        }
        
        precipitationIcon.snp.makeConstraints { make in
            make.centerY.equalTo(precipitationTitleLabel)
            make.right.equalTo(precipitationTitleLabel.snp.left).offset(-4)
            make.height.width.equalTo(14)
        }
        
        precipitationLabel.snp.makeConstraints { make in
            make.centerY.equalTo(precipitationTitleLabel)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(19)
        }
        
        cloudsTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(precipitationTitleLabel)
            make.top.equalTo(precipitationTitleLabel.snp.bottom).offset(8)
            make.height.equalTo(19)
        }
        
        cloudsIcon.snp.makeConstraints { make in
            make.centerY.equalTo(cloudsTitleLabel)
            make.right.equalTo(cloudsTitleLabel.snp.left).offset(-4)
            make.height.width.equalTo(14)
        }
        
        cloudsLabel.snp.makeConstraints { make in
            make.centerY.equalTo(cloudsTitleLabel)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(19)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(cloudsTitleLabel.snp.bottom).offset(8)
            make.bottom.equalToSuperview()
            make.left.equalTo(dateLabel)
            make.right.equalTo(feelsLikeLabel)
            make.height.equalTo(0.5)
        }
    }
    
    private func fillLabels() {
        guard let hourlyData = oneHourData else {
            return
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEEEE dd/MM"
        formatter.locale = Locale(identifier: "ru_RU")
        let date = Date(timeIntervalSince1970: hourlyData.dt)
        dateLabel.text = formatter.string(from: date)
        timeLabel.text = ConvertService.shared.timeUsingSavedSettings(dateInSeconds: hourlyData.dt)
        temperatureLabel.text = ConvertService.shared.temperatureUsingSavedSetting(temperature: hourlyData.temp)
        weatherDescriptionLabel.text = hourlyData.weather.weatherDescription.capitalizingFirstLetter()
        feelsLikeLabel.text = "По ощущениям: " + ConvertService.shared.temperatureUsingSavedSetting(temperature: hourlyData.feelsLike)
        let windSpeed: String = ConvertService.shared.windSpeedUsingSavedSettings(windSpeed: Int16(hourlyData.windSpeed))
        let windDirection: String = ConvertService.shared.windDirection(from: Double(hourlyData.windDeg))
        windSpeedLabel.text = windSpeed + " " + windDirection
        precipitationLabel.text = "\(Int(hourlyData.pop))%"
        cloudsLabel.text = "\(hourlyData.clouds)%"
    }
}
