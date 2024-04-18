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
        //        view.addSubview(precipitation)
        //        view.addSubview(wind)
        //        view.addSubview(humidity)
        //        view.addSubview(pressure)
        //        view.addSubview(windSock)
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
    
    // Изменение изображения в зависимости от погоды - пока не работает(
//        func getImageNameForWeatherDescription(_ description: String) -> String {
//            switch description {
//            case "clear sky":
//                return "sun"
//            case "cloudy day":
//                return "cloudyDay"
//            case "scattered clouds":
//                return "scattered_clouds"
//            case "light rain":
//                return "light_rain"
//            case "overcast clouds":
//                return "cloud"
//            default:
//                return "unknown_weather"
//            }
//        }
    
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
        self.todayWeatherInfoView.windSockLabel.text = "\(weatherData.wind.deg)"

        self.imageView.image = UIImage(named: "sun")
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
        debugPrint(weatherData)
    }
    
    //MARK: Для открытия "поделиться" используется UIActivityViewController
    @objc func buttonShareTapped(_ sender: UIButton) {
        let sharingViewController = UIActivityViewController(activityItems: ["weatherAsText"], applicationActivities: [])
        self.present(sharingViewController, animated: true)
    }
}

extension TodayViewController: TodayWeatherResultDelegate {
    func toggleAlert(message: String) {
        debugPrint(message) //Тут надо показать адерт, что не так
    }
    
    func updateWeatherData(weatherModel: ForecastDTO?) {
        self.updateInfo(weatherModel)
    }
    
}
