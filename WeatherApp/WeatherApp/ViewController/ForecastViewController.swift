//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by Sergio Mascarpone on 22.02.24.
//

import SnapKit
import UIKit

class ForecastViewController: UIViewController {
    
    private lazy var forecastLabel = UILabel()
    private lazy var tableView = UITableView()
    private lazy var todayButton = UIButton()
    private lazy var todayButtonLabel = UIImageView()
    private lazy var forecastButton = UIButton()
    private lazy var forecastButtonLabel = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forecastInitialize()
        configureTableView()
    }
    
    //MARK: - SetUpViews
    private func forecastInitialize() {
        view.backgroundColor = .systemPink
        
        forecastLabel.text = "Forecast"
        forecastLabel.font = UIFont.systemFont(ofSize: 24)
        view.addSubview(forecastLabel)
        forecastLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(60)
        }
        
        //todayButton
        todayButton.setTitle("Today", for: .normal)
        todayButton.setTitleColor(.black, for: .normal)
        todayButton.titleLabel?.numberOfLines = 0
        view.addSubview(todayButton)
        todayButton.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(40)
            maker.bottom.equalToSuperview().inset(40)
        }
        todayButton.addTarget(self, action: #selector(buttonTodayTapped), for: .touchUpInside)
        
        //todayButtonLabel
        todayButtonLabel.image = UIImage(named: "Today")
        view.addSubview(todayButtonLabel)
        todayButtonLabel.snp.makeConstraints { maker in
            maker.height.equalTo(30)
            maker.width.equalTo(30)
            maker.left.equalToSuperview().inset(50)
            maker.bottom.equalToSuperview().inset(80)
        }
        
        //forecastButton
        forecastButton.setTitle("Forecast", for: .normal)
        forecastButton.setTitleColor(.black, for: .normal)
        forecastButton.titleLabel?.numberOfLines = 0
        view.addSubview(forecastButton)
        forecastButton.snp.makeConstraints { maker in
            maker.right.equalToSuperview().inset(40)
            maker.bottom.equalToSuperview().inset(40)
        }
//        forecastButton.addTarget(self, action: #selector(buttonForecastTapped), for: .touchUpInside)
        
        //forecastButtonLabel
        forecastButtonLabel.image = UIImage(named: "Forecast")
        view.addSubview(forecastButtonLabel)
        forecastButtonLabel.snp.makeConstraints { maker in
            maker.height.equalTo(30)
            maker.width.equalTo(30)
            maker.right.equalToSuperview().inset(50)
            maker.bottom.equalToSuperview().inset(80)
        }

                            
    }
    private func configureTableView() {
        view.addSubview(tableView)
        
    }
    
    @objc private func buttonTodayTapped() {
        let viewController = TodayViewController()
        viewController.modalPresentationStyle = .fullScreen
        dismiss(animated: true)
//        self.present(viewController, animated: true)
    }
    
//    @objc private func buttonForecastTapped() {
//        let viewController = ForecastViewController()
//        viewController.modalPresentationStyle = .fullScreen
//        self.present(viewController, animated: true)
//    }
                            
}
