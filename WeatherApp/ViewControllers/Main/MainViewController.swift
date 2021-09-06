//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Konstantin Pimbursky on 20.06.2021.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    // MARK: -PROPERTIES
    private let coordinator: Coordinator
    private var viewModel: MainOutput
    private var currentIndex: Int?
    private var pendingIndex: Int?
    private var savedForcasts: [ForecastData]?
    
    private let settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "settings"), for: .normal)
        button.tintColor = UIColor(named: "myBlack")
        button.addTarget(self, action: #selector(settingButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let locationChoiceButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "location"), for: .normal)
        button.tintColor = UIColor(named: "myBlack")
        button.addTarget(self, action: #selector(locationButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let pageControl = UIPageControl()
    
    private let pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                          navigationOrientation: .horizontal,
                                                          options: nil)
    
    private var locationViewControllers: [UIViewController] = []
    
    // MARK: -INIT
    init(coordinator: Coordinator,
         viewModel: MainOutput) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        downloadData()
        setupScreen()
    }
    
    private func setupScreen() {
        guard  let forecastData = savedForcasts else {
            fatalError("MainViewController: savedForecast = nil")
        }
        
        if forecastData.isEmpty {
            if LocationManager.shared.isEnabled() {
                viewModel.getForecastUsingGeolocation { [weak self] in
                    self?.downloadData()
                    guard let forecast = self?.savedForcasts else {
                        return
                    }
                    guard let locationViewController = self?.coordinator.createLocationViewController(with: forecast[0]) else {
                        return
                    }
                    self?.locationViewControllers.append(locationViewController)
                    self?.setupPageViewController()
                    self?.setupPageControl()
                    self?.setupButtonsViews()
                }
            } else {
                let addNewLocationViewController = coordinator.createAddNewLocationViewController()
                locationViewControllers = [addNewLocationViewController]
                setupPageViewController()
                setupPageControl()
                setupButtonsViews()
            }
        } else {
            for value in forecastData {
                let locationViewController = coordinator.createLocationViewController(with: value)
                locationViewControllers.append(locationViewController)
            }
            setupPageViewController()
            setupPageControl()
            setupButtonsViews()
        }
    }
    
    @objc private func settingButtonTapped() {
        coordinator.showSettingsScreen(updateCompletion: updatePageViewController)
    }
    
    @objc private func locationButtonTapped() {
        coordinator.showLocationChoice { [weak self] in
            self?.viewModel.downloadForecastFromDataBase { [weak self] forecastData in
                self?.savedForcasts = forecastData
                self?.updatePageViewController()
            }
        }
    }
    
    private func downloadData() {
        viewModel.downloadForecastFromDataBase { [weak self] forecastData in
            self?.savedForcasts = forecastData
        }
    }
    
    private func setupButtonsViews() {
        view.addSubview(settingsButton)
        
        view.addSubview(locationChoiceButton)
        
        settingsButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(43)
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(18)
            make.width.equalTo(34)
        }
        
        locationChoiceButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(37)
            make.right.equalToSuperview().offset(-15)
            make.width.equalTo(20)
            make.height.equalTo(26)
        }
    }
    
    private func setupPageViewController() {
        guard let first = locationViewControllers.first else {
            return
        }
        pageViewController.delegate = self
        pageViewController.dataSource = self
        pageViewController.setViewControllers([first],
                                              direction: .forward,
                                              animated: true,
                                              completion: nil)
        view.addSubview(pageViewController.view)
        
        
        pageViewController.view.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = locationViewControllers.count
        pageControl.pageIndicatorTintColor = .systemGray4
        pageControl.currentPageIndicatorTintColor = .black
        view.addSubview(pageControl)
        
        pageControl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(82)
            make.centerX.equalToSuperview()
        }
    }
    
    private func updatePageViewController() {
        locationViewControllers = []
        guard let forecastData = savedForcasts else {
            return
        }
        for value in forecastData {
            let locationViewController = coordinator.createLocationViewController(with: value)
            locationViewControllers.append(locationViewController)
        }
        guard let last = locationViewControllers.last else {
            return
        }
        pageViewController.setViewControllers([last],
                                              direction: .forward,
                                              animated: true,
                                              completion: nil)
        pageControl.numberOfPages = locationViewControllers.count
        pageControl.currentPage = pageControl.numberOfPages - 1
    }
}

extension MainViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = locationViewControllers.firstIndex(of: viewController),
              index > 0 else {
            return nil
        }
        let before = index - 1
        return locationViewControllers[before]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = locationViewControllers.firstIndex(of: viewController),
              index < (locationViewControllers.count - 1) else {
            return nil
        }
        let after = index + 1
        return locationViewControllers[after]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        pendingIndex = locationViewControllers.firstIndex(of: pendingViewControllers.first!)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            currentIndex = pendingIndex
            if let index = currentIndex {
                pageControl.currentPage = index
            }
        }
    }
}
