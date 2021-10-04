//
//  GraphCollectionViewCell.swift
//  WeatherApp
//
//  Created by Konstantin Pimbursky on 11.09.2021.
//

import UIKit

class GraphCollectionViewCell: UICollectionViewCell {
    
    // MARK: - PROPERTIES
    var forecastForOneHour: HourlyData? {
        didSet {
            fillLabels()
        }
    }
    
    var isFirstCell: Bool = false
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "MyBlack")
        label.font = UIFont(name: "Rubik-Regular", size: 12)
        return label
    }()
    
    public let temperatureDot: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "circle.fill")
        imageView.tintColor = .white
        return imageView
    }()
    
    private let weatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let probabilityOfPrecipitation: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "MyBlack")
        label.font = UIFont(name: "Rubik-Regular", size: 12)
        return label
    }()
    
    private let timeDot: UIView = {
        let someView = UIView()
        someView.backgroundColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        return someView
    }()
    
    private let timeLine: UIView = {
        let someView = UIView()
        someView.backgroundColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1)
        return someView
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "MyBlack")
        label.font = UIFont(name: "Rubik-Regular", size: 12)
        return label
    }()
    
    private let temperatureContentView: UIView = {
        let someView = UIView()
        return someView
    }()
    
    // MARK: - INIT
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - FUNCTIONS
    override func layoutSubviews() {
        super.layoutSubviews()
        drawDashedLines()
    }
    
    func putDotOfTemperature(minTemperature: Double, maxTemperature: Double) {
        temperatureContentView.addSubviews(temperatureDot, temperatureLabel)
        
        guard let hourForecast = forecastForOneHour else {
            return
        }
        let differenceBitweenMaxAndMinTemp = maxTemperature - minTemperature
        let pointsPerDegree = 25 / differenceBitweenMaxAndMinTemp
        let currentTemperatureOffset = Int((maxTemperature - hourForecast.temp) * pointsPerDegree)
        temperatureLabel.text = ConvertService.shared.temperatureUsingSavedSetting(temperature: hourForecast.temp)
        
        temperatureDot.snp.remakeConstraints { make in
            make.top.equalTo(temperatureContentView.snp.top).offset(currentTemperatureOffset)
            make.left.equalToSuperview()
            make.height.width.equalTo(4)
        }
        
        temperatureLabel.snp.remakeConstraints { make in
            make.bottom.equalTo(temperatureDot.snp.top).offset(-2)
            make.left.equalToSuperview()
        }
    }
    
    private func setupViews() {
        contentView.addSubviews(temperatureContentView, weatherIcon, probabilityOfPrecipitation, timeDot, timeLine, timeLabel)
        
        temperatureContentView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(31)
            make.left.right.equalToSuperview()
            make.height.equalTo(25)
        }
        
        weatherIcon.snp.makeConstraints { make in
            make.top.equalTo(temperatureContentView.snp.bottom).offset(14)
            make.left.equalToSuperview()
            make.height.width.equalTo(16)
        }
        
        probabilityOfPrecipitation.snp.makeConstraints { make in
            make.top.equalTo(weatherIcon.snp.bottom).offset(4)
            make.left.equalToSuperview()
        }
        
        timeDot.snp.makeConstraints { make in
            make.top.equalTo(probabilityOfPrecipitation.snp.bottom).offset(9)
            make.left.equalToSuperview()
            make.height.equalTo(8)
            make.width.equalTo(4)
        }
        
        timeLine.snp.makeConstraints { make in
            make.centerY.equalTo(timeDot.snp.centerY)
            make.left.right.equalToSuperview()
            make.height.equalTo(0.5)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(timeDot.snp.bottom).offset(8)
            make.left.equalToSuperview()
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
    private func fillLabels() {
        guard let hourForecast = forecastForOneHour else {
            return
        }
        if UserDefaults.standard.string(forKey: "temperature") == "C" {
            temperatureLabel.text = "\(Int(hourForecast.temp))\u{00B0}"
        } else {
            temperatureLabel.text = "\(Int((hourForecast.temp * 9/5) + 32))\u{00B0}"
        }
        weatherIcon.image = UIImage(named: hourForecast.weather.icon)
        probabilityOfPrecipitation.text = "\(Int(hourForecast.pop))%"
        let timeFormatter = DateFormatter()
        if UserDefaults.standard.string(forKey: "dateFormat") == "24" {
            timeFormatter.dateFormat = "HH:mm"
        } else {
            timeFormatter.dateFormat = "hh:mm"
        }
        timeLabel.text = timeFormatter.string(from: Date(timeIntervalSince1970: hourForecast.dt))
    }
    
    public func drawDashedLines() {
        if isFirstCell {
            addDashedLine(begin: CGPoint(x: temperatureContentView.frame.minX,
                                         y: temperatureContentView.frame.minY),
                          end: CGPoint(x: temperatureContentView.frame.minX,
                                       y: temperatureContentView.frame.maxY))
        }
        addDashedLine(begin: CGPoint(x: temperatureContentView.frame.minX,
                                     y: temperatureContentView.frame.maxY),
                      end: CGPoint(x: temperatureContentView.frame.maxX,
                                   y: temperatureContentView.frame.maxY))
    }
    
    private func addDashedLine(begin: CGPoint, end: CGPoint) {
        let lineDashPattern: [NSNumber]  = [3,3]
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor(red: 0.125, green: 0.306, blue: 0.78, alpha: 1).cgColor
        shapeLayer.lineWidth = 0.3
        shapeLayer.lineDashPattern = lineDashPattern
        
        let path = CGMutablePath()
        path.addLines(between: [begin, end])
        
        shapeLayer.path = path
        self.layer.addSublayer(shapeLayer)
    }
}
