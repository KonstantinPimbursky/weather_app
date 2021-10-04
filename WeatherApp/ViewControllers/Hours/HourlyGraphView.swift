//
//  HourlyGraphView.swift
//  WeatherApp
//
//  Created by Konstantin Pimbursky on 06.09.2021.
//

import UIKit

class HourlyGraphView: UIView {

    // MARK: - PROPERTIES
    private let hourlyData: [HourlyData]
    
    let minTemperature: Double
    let maxTemperature: Double
    
    private let graphCollectionView: UICollectionView = {
        let celSize = CGSize(width: 51, height: 152)
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize = celSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
        return collectionView
    }()
    
    // MARK: - INIT
    init(hourlyData: [HourlyData]) {
        self.hourlyData = hourlyData
        self.maxTemperature = hourlyData.max(by: {$0.temp < $1.temp})!.temp
        self.minTemperature = hourlyData.max(by: {$0.temp > $1.temp})!.temp
        super.init(frame: .zero)
        self.backgroundColor = UIColor(red: 0.914, green: 0.933, blue: 0.98, alpha: 1)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - FUNCTIONS
    func setupSubviews() {
        graphCollectionView.delegate = self
        graphCollectionView.dataSource = self
        graphCollectionView.register(GraphCollectionViewCell.self, forCellWithReuseIdentifier: "GraphCollectionViewCell")
        
        self.addSubview(graphCollectionView)
        
        graphCollectionView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(18)
            make.right.equalToSuperview().offset(-18)
            make.height.equalTo(152)
        }
    }
}

// MARK: - EXTENSIONS
extension HourlyGraphView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: GraphCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GraphCollectionViewCell", for: indexPath) as! GraphCollectionViewCell
        cell.forecastForOneHour = hourlyData[indexPath.item]
        cell.putDotOfTemperature(minTemperature: minTemperature, maxTemperature: maxTemperature)
        if indexPath.item == 0 {
            cell.isFirstCell = true
        } else {
            cell.isFirstCell = false
        }
        return cell
    }
    
    
}
