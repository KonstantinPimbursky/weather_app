//
//  SettingsViewController.swift
//  WeatherApp
//
//  Created by Konstantin Pimbursky on 22.06.2021.
//

import UIKit
import SnapKit

class SettingsViewController: UIViewController {
    
    // MARK: - PROPERTIES
    private let firstCloudImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cloud_1")?.alpha(0.3)
        return imageView
    }()
    
    private let secondCloudImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cloud_2")
        return imageView
    }()
    
    private let thirdCloudImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cloud_3")
        return imageView
    }()
    
    private let contentView: UIView = {
        let someView = UIView()
        someView.backgroundColor = UIColor(named: "myWhite")
        someView.layer.cornerRadius = 10
        return someView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Настройки"
        label.font = UIFont(name: "Rubik-Medium", size: 18)
        label.textColor =  UIColor(named: "myBlack")
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "Температура"
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor =  UIColor(named: "myGrey")
        return label
    }()
    
    private let windSpeedLabel: UILabel = {
        let label = UILabel()
        label.text = "Скорость ветра"
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor =  UIColor(named: "myGrey")
        return label
    }()
    
    private let dateFormatLabel: UILabel = {
        let label = UILabel()
        label.text = "Формат времени"
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor =  UIColor(named: "myGrey")
        return label
    }()
    
    private let notificationsLabel: UILabel = {
        let label = UILabel()
        label.text = "Уведомления"
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor =  UIColor(named: "myGrey")
        return label
    }()
    
    private let setPreferencesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Установить", for: .normal)
        button.backgroundColor = UIColor(named: "myOrange")
        button.titleLabel?.font = UIFont(name: "Rubik-Regular", size: 16)
        button.setTitleColor(UIColor(named: "myWhite"), for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(setPreferencesButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let temperatureSegmentedControl: UISegmentedControl = {
        let items = ["C", "F"]
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 0
        control.layer.cornerRadius = 5
        control.layer.borderWidth = 0
        control.layer.masksToBounds = true
        control.backgroundColor = UIColor(named: "myPeach")
        control.selectedSegmentTintColor = UIColor(named: "darkBlue")
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
        return control
    }()
    
    private let windSpeedSegmentedControl: UISegmentedControl = {
        let items = ["Mi", "Km"]
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 0
        control.layer.cornerRadius = 5
        control.layer.borderWidth = 0
        control.layer.masksToBounds = true
        control.backgroundColor = UIColor(named: "myPeach")
        control.selectedSegmentTintColor = UIColor(named: "darkBlue")
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
        return control
    }()
    
    private let dateFormatSegmentedControl: UISegmentedControl = {
        let items = ["12", "24"]
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 0
        control.layer.cornerRadius = 5
        control.layer.borderWidth = 0
        control.layer.masksToBounds = true
        control.backgroundColor = UIColor(named: "myPeach")
        control.selectedSegmentTintColor = UIColor(named: "darkBlue")
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
        return control
    }()
    
    private let notificationsSegmentedControl: UISegmentedControl = {
        let items = ["On", "Off"]
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 0
        control.layer.cornerRadius = 5
        control.layer.borderWidth = 0
        control.layer.masksToBounds = true
        control.backgroundColor = UIColor(named: "myPeach")
        control.selectedSegmentTintColor = UIColor(named: "darkBlue")
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: UIControl.State.selected)
        return control
    }()
    
    // MARK: - FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    @objc private func setPreferencesButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor(named: "mainBlue")
        
        view.addSubview(firstCloudImageView)
        view.addSubview(secondCloudImageView)
        view.addSubview(thirdCloudImageView)
        view.addSubview(contentView)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(temperatureLabel)
        contentView.addSubview(windSpeedLabel)
        contentView.addSubview(dateFormatLabel)
        contentView.addSubview(notificationsLabel)
        contentView.addSubview(setPreferencesButton)
        contentView.addSubview(temperatureSegmentedControl)
        contentView.addSubview(windSpeedSegmentedControl)
        contentView.addSubview(dateFormatSegmentedControl)
        contentView.addSubview(notificationsSegmentedControl)
        
        firstCloudImageView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(37)
            make.left.equalToSuperview()
            make.height.equalTo(58.1)
        }
        
        secondCloudImageView.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(121)
            make.right.equalToSuperview().offset(-2.3)
            make.height.equalTo(94.2)
        }
        
        contentView.snp.makeConstraints{ make in
            make.center.equalToSuperview()
            make.width.equalTo(320)
            make.height.equalTo(330)
        }
        
        thirdCloudImageView.snp.makeConstraints{ make in
            make.top.equalTo(contentView.snp.bottom).offset(81)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(27)
            make.left.equalToSuperview().offset(20)
        }
        
        temperatureLabel.snp.makeConstraints{ make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
        }
        
        windSpeedLabel.snp.makeConstraints{ make in
            make.top.equalTo(temperatureLabel.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(20)
        }
        
        dateFormatLabel.snp.makeConstraints{ make in
            make.top.equalTo(windSpeedLabel.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(20)
        }
        
        notificationsLabel.snp.makeConstraints{ make in
            make.top.equalTo(dateFormatLabel.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(20)
        }
        
        setPreferencesButton.snp.makeConstraints{ make in
            make.top.equalTo(notificationsLabel.snp.bottom).offset(42)
            make.left.equalToSuperview().offset(35)
            make.right.equalToSuperview().offset(-35)
            make.height.equalTo(40)
        }
        
        temperatureSegmentedControl.snp.makeConstraints{ make in
            make.right.equalToSuperview().offset(-30)
            make.centerY.equalTo(temperatureLabel.snp.centerY)
            make.height.equalTo(30)
            make.width.equalTo(80)
        }
        
        windSpeedSegmentedControl.snp.makeConstraints{ make in
            make.right.equalToSuperview().offset(-30)
            make.centerY.equalTo(windSpeedLabel.snp.centerY)
            make.height.equalTo(30)
            make.width.equalTo(80)
        }
        
        dateFormatSegmentedControl.snp.makeConstraints{ make in
            make.right.equalToSuperview().offset(-30)
            make.centerY.equalTo(dateFormatLabel.snp.centerY)
            make.height.equalTo(30)
            make.width.equalTo(80)
        }
        
        notificationsSegmentedControl.snp.makeConstraints{ make in
            make.right.equalToSuperview().offset(-30)
            make.centerY.equalTo(notificationsLabel.snp.centerY)
            make.height.equalTo(30)
            make.width.equalTo(80)
        }
    }

}

// MARK: - EXTENSIONS
extension UIImage {
func alpha(_ value:CGFloat) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(size, false, scale)
    draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage!
    }
}
