//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by Sergio Mascarpone on 22.02.24.
//

import SnapKit
import UIKit

class ForecastViewController: UIViewController {
    
    
    private lazy var forecastLabel = UITextField()
    private lazy var tableView = UITableView()
    private lazy var reuseIdentifier = "Forecast"
    private lazy var todayButton = UIButton()
    private lazy var todayButtonLabel = UIImageView()
    private lazy var forecastButton = UIButton()
    private lazy var forecastButtonLabel = UIImageView()
    
//    private lazy var dayForecast = [
//        weakDay(image: "", date: "", weather: "", temperature: ""),
//        weakDay(image: "", date: "", weather: "", temperature: ""),
//        weakDay(image: "", date: "", weather: "", temperature: ""),
//        weakDay(image: "", date: "", weather: "", temperature: ""),
//        weakDay(image: "", date: "", weather: "", temperature: ""),
//        weakDay(image: "", date: "", weather: "", temperature: ""),
//        weakDay(image: "", date: "", weather: "", temperature: ""),
//        weakDay(image: "", date: "", weather: "", temperature: ""),
//        weakDay(image: "", date: "", weather: "", temperature: ""),
//        weakDay(image: "", date: "", weather: "", temperature: "")
//    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTableView()
        forecastInitialize()
    }
    
    //MARK: - SetUpViews
    private func forecastInitialize() {
        
        forecastLabel.text = "Forecast"
        forecastLabel.font = UIFont.systemFont(ofSize: 24)
        view.addSubview(forecastLabel)
        forecastLabel.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.top.equalToSuperview().inset(60)
        }
        
        //todayButton
        todayButton.setTitle("Today", for: .normal)
        todayButton.setTitleColor(.black, for: .normal)
        todayButton.titleLabel?.numberOfLines = 0
        view.addSubview(todayButton)
        todayButton.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(40)
            maker.bottom.equalToSuperview().inset(20)
        }
        todayButton.addTarget(self, action: #selector(buttonTodayTapped), for: .touchUpInside)
        
        //todayButtonLabel
        todayButtonLabel.image = UIImage(named: "Today")
        view.addSubview(todayButtonLabel)
        todayButtonLabel.snp.makeConstraints { maker in
            maker.height.equalTo(30)
            maker.width.equalTo(30)
            maker.left.equalToSuperview().inset(50)
            maker.bottom.equalToSuperview().inset(50)
        }
        
        //forecastButton
        forecastButton.setTitle("Forecast", for: .normal)
        forecastButton.setTitleColor(.black, for: .normal)
        forecastButton.titleLabel?.numberOfLines = 0
        view.addSubview(forecastButton)
        forecastButton.snp.makeConstraints { maker in
            maker.right.equalToSuperview().inset(40)
            maker.bottom.equalToSuperview().inset(20)
        }
        //        forecastButton.addTarget(self, action: #selector(buttonForecastTapped), for: .touchUpInside)
        
        //forecastButtonLabel
        forecastButtonLabel.image = UIImage(named: "Forecast")
        view.addSubview(forecastButtonLabel)
        forecastButtonLabel.snp.makeConstraints { maker in
            maker.height.equalTo(30)
            maker.width.equalTo(30)
            maker.right.equalToSuperview().inset(50)
            maker.bottom.equalToSuperview().inset(50)
        }
        
        
    }
    
    private func configureTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    tableView.rowHeight = 80
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.top.equalToSuperview().inset(90)
            make.bottom.equalToSuperview().inset(80)
        }

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

//MARK: -
extension ForecastViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)
        cell?.imageView?.image = UIImage(named: "Cloud")
        cell?.textLabel?.text = "26.04.2024 | 0:00"
        return cell!
    }
    
    
}


