//
//  OnboardingViewController.swift
//  WeatherApp
//
//  Created by Konstantin Pimbursky on 20.06.2021.
//

import UIKit
import SnapKit

class OnboardingViewController: UIViewController {
    
    // MARK: - PROPERTIES
    private let coordinator: Coordinator
    
    private let onboardingImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "umbrella")
        return imageView
    }()
    
    private let requestTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Разрешить приложению Weather использовать данные о местоположении вашего устройства"
        label.numberOfLines = 0
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.textColor = UIColor(red: 248/255,
                                  green: 245/255,
                                  blue: 245/255,
                                  alpha: 1.0)
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Чтобы получить более точные прогнозы погоды во время движения или путешествия"
        label.numberOfLines = 0
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = .white
        return label
    }()
    
    private let additionalInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "Вы можете изменить свой выбор в любое время из меню приложения"
        label.numberOfLines = 0
        label.font = UIFont(name: "Rubik-Regular", size: 14)
        label.textColor = .white
        return label
    }()
    
    private let acceptButton: UIButton = {
        let button = UIButton()
        button.setTitle("ИСПОЛЬЗОВАТЬ МЕСТОПОЛОЖЕНИЕ УСТРОЙСТВА", for: .normal)
        button.backgroundColor = UIColor(named: "myOrange")
        button.titleLabel?.font = UIFont(name: "Rubik-Regular", size: 12)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(acceptButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("НЕТ, Я БУДУ ДОБАВЛЯТЬ ЛОКАЦИИ", for: .normal)
        button.contentHorizontalAlignment = .right
        button.titleLabel?.font =  UIFont(name: "Rubik-Regular", size: 16)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: -INIT
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        setupViews()
    }
    
    @objc private func acceptButtonTapped() {
        FirstStartIndicator.shared.setNotFirstStart()
        LocationManager.shared.startGetLocation { [weak self] in
            self?.coordinator.showMainViewController()
        }
    }
    
    @objc private func cancelButtonTapped() {
        FirstStartIndicator.shared.setNotFirstStart()
        coordinator.showMainViewController()
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor(named: "mainBlue")
        view.addSubview(onboardingImage)
        view.addSubview(requestTitleLabel)
        view.addSubview(infoLabel)
        view.addSubview(additionalInfoLabel)
        view.addSubview(acceptButton)
        view.addSubview(cancelButton)
        
        onboardingImage.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(63)
            make.centerX.equalToSuperview()
        }
        
        requestTitleLabel.snp.makeConstraints{ make in
            make.top.equalTo(onboardingImage.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(19)
            make.right.equalToSuperview().offset(-34)
        }
        
        infoLabel.snp.makeConstraints{ make in
            make.top.equalTo(requestTitleLabel.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(19)
            make.right.equalToSuperview().offset(-42)
        }
        
        additionalInfoLabel.snp.makeConstraints{ make in
            make.top.equalTo(infoLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(19)
            make.right.equalToSuperview().offset(-42)
        }
        
        acceptButton.snp.makeConstraints{ make in
            make.top.equalTo(additionalInfoLabel.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(18)
            make.right.equalToSuperview().offset(-17)
            make.height.equalTo(40)
        }
        
        cancelButton.snp.makeConstraints{ make in
            make.top.equalTo(acceptButton.snp.bottom).offset(25)
            make.left.equalToSuperview().offset(36)
            make.right.equalToSuperview().offset(-17)
        }
    }
}
