//
//  MoreForHoursViewController.swift
//  WeatherApp
//
//  Created by Konstantin Pimbursky on 11.07.2021.
//

import UIKit

class MoreForHoursViewController: UIViewController {

    // MARK: - PROPERTIES
    private let hourlyData: [HourlyData]
    private let coordinator: Coordinator
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(backButtonTaped), for: .touchUpInside)
        button.contentMode = .scaleAspectFill
        button.snp.makeConstraints { make in
            make.width.equalTo(15)
        }
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Прогноз на 24 часа"
        label.textColor = UIColor(red: 0.6, green: 0.59, blue: 0.59, alpha: 1.0)
        label.font = UIFont(name: "Rubik-Regular", size: 16)
        label.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.15, green: 0.15, blue: 0.13, alpha: 1.0)
        label.font = UIFont(name: "Rubik-Medium", size: 18)
        label.snp.makeConstraints { make in
            make.height.equalTo(22)
        }
        return label
    }()
    
    private let hourlyGraphView: HourlyGraphView
    
    private let hourForecastDetailsTableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    // MARK: - INIT
    init(location: String,
         hourlyData: [HourlyData],
         coordinator: Coordinator) {
        self.hourlyData = hourlyData
        self.coordinator = coordinator
        self.locationLabel.text = location
        self.hourlyGraphView = HourlyGraphView(hourlyData: hourlyData)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        hourForecastDetailsTableView.delegate = self
        hourForecastDetailsTableView.dataSource = self
        hourForecastDetailsTableView.register(HourForecastDetailsTableViewCell.self, forCellReuseIdentifier: "HourForecastDetailsTableViewCell")
        setupViews()
    }
    
    @objc private func backButtonTaped() {
        coordinator.goBack()
    }
    
    func setupViews() {
        view.addSubviews(backButton, titleLabel, locationLabel, hourlyGraphView, hourForecastDetailsTableView)
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(59)
            make.left.equalToSuperview().offset(17)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton.snp.centerY)
            make.left.equalTo(backButton.snp.right).offset(20)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(48)
        }
        
        hourlyGraphView.snp.makeConstraints { make in
            make.top.equalTo(locationLabel.snp.bottom).offset(15)
            make.left.right.equalToSuperview()
//            make.height.equalTo(152)
        }
        
        hourForecastDetailsTableView.snp.makeConstraints { make in
            make.top.equalTo(hourlyGraphView.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
}

extension MoreForHoursViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 24
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HourForecastDetailsTableViewCell") as! HourForecastDetailsTableViewCell
        cell.oneHourData = hourlyData[indexPath.item]
        return cell
    }
    
    
}
