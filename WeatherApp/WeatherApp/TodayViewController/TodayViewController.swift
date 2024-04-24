//
//  ViewController.swift
//  WeatherApp
//
//  Created by Sergio Mascarpone on 21.02.24.
//

import Foundation
import SnapKit
import UIKit
import CoreLocation
import Alamofire

class TodayViewController: UIViewController {
    
    var todayWeatherInfoView: TodayWeatherInfo!
    private var imageView = UIImageView()
    private lazy var cityNameLocationLabel = UILabel()
    private lazy var temperatureLabel = UILabel()
    private lazy var shareButton = UIButton()
    let weatherManager = WeatherManager()
    private var presenter: TodayWeatherPresenterProtocol
    
    init(presenter: TodayWeatherPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.presenter.todayWeatherResultDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todayInitialize()
        
        //Создание экземпляра из XIB.
        todayWeatherInfoView = TodayWeatherInfo()
        self.view.addSubview(todayWeatherInfoView)
                todayWeatherInfoView.snp.makeConstraints { make in
                    make.top.centerY.equalTo(340)
    }
        
        weatherManager.fetchWeatherData { [weak self] weatherData in
            guard weatherData != nil else { return }
            
            DispatchQueue.main.async {
                self?.displayWeatherData(weatherData!)
            }
        }
    }
    
    // Изменение изображения в зависимости от погоды - работает)
    func weatherImageName(for weatherDescription: String) -> String {
        switch weatherDescription.lowercased() {
            case let str where str.contains("clear"): return "sun"
            case let str where str.contains("overcast clouds"): return "cloud"
            case let str where str.contains("clouds"): return "cloudyDay"
            case let str where str.contains("snow"): return "snowing"
            case let str where str.contains("rain"): return "rain"
            default: return "unknown"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.requestLocationIfNeeded()
    }
   
    // Вывод данных о погоде на экран
    func displayWeatherData(_ weatherData: WeatherData) {
        
        self.cityNameLocationLabel.text = "\(weatherData.name)"
        self.temperatureLabel.text = "\(weatherData.main.temp)°C | \(weatherData.weather.first?.description ?? "Unknown")"
        self.todayWeatherInfoView.humidLabel.text = "\(weatherData.main.humidity) %"
        self.todayWeatherInfoView.windyLabel.text = "\(weatherData.wind.speed) km/h"
        self.todayWeatherInfoView.termometerLabel.text = "\(weatherData.main.humidity) mm"
        self.todayWeatherInfoView.pressureLabel.text = "\(weatherData.main.pressure) hPa"
        
        //Вывод и конвертирование, направления ветра.
        let windDirection = presenter.defineWindDirection(degree: weatherData.wind.deg)
        self.todayWeatherInfoView.windSockLabel.text = windDirection

        //Вывод иконки по описанию погоды.
        self.imageView.image = UIImage(named: weatherImageName(for: weatherData.weather.first?.description ?? ""))
    }
    
    //MARK: - SetUpViews
    private func todayInitialize() {
        view.backgroundColor = .systemBackground
        
        //imageView
        imageView.image = UIImage()
        view.addSubview(imageView)
        imageView.snp.makeConstraints { maker in
            maker.height.equalTo(100)
            maker.width.equalTo(100)
            maker.centerX.equalToSuperview()
            maker.top.equalToSuperview().inset(100)
        }
        
        //cityNameLocationLabel
        cityNameLocationLabel.text = " "
        cityNameLocationLabel.font = UIFont(name: "AmericanTypewriter", size: 30)
        view.addSubview(cityNameLocationLabel)
        cityNameLocationLabel.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.top.equalToSuperview().inset(220)
        }
        
        //descriptionLabel
        temperatureLabel.text = ""
        temperatureLabel.font = UIFont(name: "AmericanTypewriter", size: 26)
        view.addSubview(temperatureLabel)
        temperatureLabel.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.top.equalToSuperview().inset(280)
        }
        
        //shareButton
        shareButton.backgroundColor = .green
        shareButton.setTitle("Share Weather", for: .normal)
        shareButton.setTitleColor(.black, for: .normal)
        shareButton.layer.cornerRadius = 20
        view.addSubview(shareButton)
        shareButton.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.width.equalTo(150)
            maker.bottom.equalToSuperview().inset(100)
            maker.height.equalTo(40)
        }
        shareButton.addTarget(self, action: #selector(buttonShareTapped), for: .touchUpInside)
    }
    
    func updateInfo(_ weatherData: ForecastDTO?) {
        debugPrint(weatherData!)
    }
    
    //MARK: Для открытия "поделиться" используется UIActivityViewController
    @objc func buttonShareTapped(_ sender: UIButton) {
        let sharingViewController = UIActivityViewController(activityItems: ["weatherAsText"], applicationActivities: [])
        self.present(sharingViewController, animated: true)
    }
}

extension TodayViewController: TodayWeatherResultDelegate {
    func toggleAlert(message: String) {
        debugPrint("Please - connect to the Internet") //Тут надо показать адерт, что не так
    }
    
    func updateWeatherData(weatherModel: ForecastDTO?) {
        self.updateInfo(weatherModel)
    }
    
}
