//
//  AddNewLocationViewController.swift
//  WeatherApp
//
//  Created by Konstantin Pimbursky on 18.07.2021.
//

import UIKit
import SnapKit

class AddNewLocationViewController: UIViewController {
    
    private let coordinator: Coordinator
    
    private let plusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "plus")
        imageView.tintColor = .black
        return imageView
    }()
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(plusImageView)
        
        plusImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(100)
        }
    }

}
