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

class TodayViewController: UIViewController, CLLocationManagerDelegate {
    
    private lazy var dateLabel = UILabel()
    private lazy var imageView = UIImageView()
    private lazy var cityNameLocationLabel = UILabel()
    private lazy var temperatureLabel = UILabel()
    //    private lazy var humidView = UIImageView()
    //    private lazy var humidLabel = UILabel()
    //    private lazy var windSpeedView = UIImageView()
    //    private lazy var windSpeedLabel = UILabel()
    //    private lazy var thermoView = UIImageView()
    //    private lazy var thermoLabel = UILabel()
    //    private lazy var pressureView = UIImageView()
    //    private lazy var pressureLabel = UILabel()
    //    private lazy var windSockView = UIImageView()
    //    private lazy var windSockLabel = UILabel()
    private lazy var shareButton = UIButton()
    
    //Views
    private lazy var precipitation: WeatherPrecipitationView = {
        let precipitation = WeatherPrecipitationView(state: .precipitation)
        return precipitation
    }()
    
    private lazy var wind: WeatherWindView = {
        let wind = WeatherWindView(state: .wind)
        return wind
    }()
    
    private lazy var humidity: WeatherHumidityView = {
        let humidity = WeatherHumidityView(state: .humidity)
        return humidity
    }()
    
    private lazy var pressure: WeatherPressureView = {
        let pressure = WeatherPressureView(state: .pressure)
        return pressure
    }()
    
    private lazy var windSock: WeatherWindsockView = {
        let windSock = WeatherWindsockView(state: .windsock)
        return windSock
    }()
    
    //    let apiKey = "70b9166dc33204c62ee3c1e299ac88ee"
    
    let weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todayInitialize()
        getLocation()
        view.addSubview(precipitation)
        view.addSubview(wind)
        view.addSubview(humidity)
        view.addSubview(pressure)
        view.addSubview(windSock)
        
        
        weatherManager.fetchWeatherData { [weak self] weatherData in
            guard let weatherData = weatherData else { return }
            
            DispatchQueue.main.async {
                self?.displayWeatherData(weatherData)
            }
        }
    }
    
    func displayWeatherData(_ weatherData: WeatherData) {
        // Вывод данных о погоде на экран
        print("\(weatherData.name)")
        print("\(weatherData.main.temp)°C")
        print("Влажность: \(weatherData.main.humidity) %")
        print("Скорость ветра: \(weatherData.wind.speed) м/с")
        print("Вероятность осадков: \(weatherData.weather.first?.description ?? "Unknown")")
        
        self.cityNameLocationLabel.text = "\(weatherData.name)"
        self.temperatureLabel.text = "\(weatherData.main.temp)°C | \(weatherData.weather.first?.description ?? "Unknown")"
        self.precipitation.subtitle.text = "\(weatherData.main.humidity) mm"
        self.wind.subtitle.text = "\(weatherData.wind.speed) km/h"
        self.humidity.subtitle.text = "\(weatherData.main.humidity) %"
        self.pressure.subtitle.text = "\(weatherData.main.pressure) hPa"
        self.windSock.subtitle.text = "\(weatherData.wind.deg) "
    }
    
    //        let url = "https://api.openweathermap.org/data/2.5/weather?q=Minsk&appid=\(apiKey)&units=metric"
    //
    //        AF.request(url).responseJSON { response in
    //            switch response.result {
    //            case .success(let value):
    //                if let json = value as? [String: Any],
    //                   let name = json["name"] as? String,
    //                   let main = json["main"] as? [String: Any],
    //                   let temp = main["temp"] as? Double,
    //                   let humidity = main["humidity"] as? Int,
    //                   let wind = json["wind"] as? [String: Any],
    //                   let windSpeed = wind["speed"] as? Double,
    //                   let weather = json["weather"] as? [[String: Any]],
    //                   let rain = weather.first?["description"] as? String {
    //
    //                    // Обновление текста в UILabel
    //                    DispatchQueue.main.async {
    //                        self.cityNameLocationLabel.text = "\(name)"
    //                        self.temperatureLabel.text = "\(temp) °C | \(rain)"
    //
    //                        //Изменение изображения в зависимости от погоды
    ////                         let imageName =
    ////                         self.getImageNameForWeatherDescription(description)
    ////                         self.imageView.image = UIImage(named: imageName)
    //                    }
    //                }
    //            case .failure(let error):
    //                print(error)
    //            }
    //        }
    //    }
    
    // Изменение изображения в зависимости от погоды
    //    func getImageNameForWeatherDescription(_ description: String) -> String {
    //        switch description {
    //        case "clear sky":
    //            return "sun"
    //        case "cloudy day":
    //            return "cloudyDay"
    //        case "scattered clouds":
    //            return "scattered_clouds"
    //        case "light rain":
    //            return "light_rain"
    //            // добавить другие кейсы для других типов погоды
    //        default:
    //            return "unknown_weather"
    //        }
    //    }
    
    //LocationManager
    private func getLocation() {
        LocationManager.shared.getCorrentLocation { location in
            print(String(describing:location))
        }
    }
    
    //MARK: - SetUpViews
    private func todayInitialize() {
        view.backgroundColor = .systemBackground
        
        //dateLabel
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        
        let date = Date()
        
        dateLabel.text = (dateFormatter.string(from: date))
        dateLabel.font = UIFont.systemFont(ofSize: 24)
        view.addSubview(dateLabel)
        dateLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(60)
        }
        
        //imageView
        imageView.image = UIImage(named: "sun")
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
        
        //        //humidView
        //        humidView.image = UIImage(named: "humid")
        //        view.addSubview(humidView)
        //        humidView.snp.makeConstraints { maker in
        //            maker.height.equalTo(80)
        //            maker.width.equalTo(80)
        //            maker.left.equalToSuperview().inset(40)
        //            maker.top.equalToSuperview().inset(350)
        //        }
        //
        //        //humidLabel
        //        humidLabel.text = "0 mm"
        //        humidLabel.font = UIFont(name: "Times New Roman", size: 22)
        //        view.addSubview(humidLabel)
        //        humidLabel.snp.makeConstraints { maker in
        ////            maker.top.equalTo(humidView.snp.bottom).offset(0)
        //            maker.left.equalToSuperview().inset(55)
        //            maker.top.equalToSuperview().inset(440)
        //        }
        
        //        //windSpeedView
        //        windSpeedView.image = UIImage(named: "windySpeed")
        //        view.addSubview(windSpeedView)
        //        windSpeedView.snp.makeConstraints { maker in
        //            maker.height.equalTo(80)
        //            maker.width.equalTo(80)
        //            maker.centerX.equalToSuperview()
        //            maker.top.equalToSuperview().inset(350)
        //        }
        //
        //        //windSpeedLabel
        //        windSpeedLabel.text = "0.45 km/h"
        //        windSpeedLabel.font = UIFont(name: "Times New Roman", size: 22)
        //        view.addSubview(windSpeedLabel)
        //        windSpeedLabel.snp.makeConstraints { maker in
        //            maker.centerX.equalToSuperview()
        //            maker.top.equalToSuperview().inset(440)
        //        }
        
        //        //thermoView
        //        thermoView.image = UIImage(named: "temperature")
        //        view.addSubview(thermoView)
        //        thermoView.snp.makeConstraints { maker in
        //            maker.height.equalTo(80)
        //            maker.width.equalTo(80)
        //            maker.right.equalToSuperview().inset(40)
        //            maker.top.equalToSuperview().inset(350)
        //        }
        
        //        //thermoLabel
        //        thermoLabel.text = "69 %"
        //        thermoLabel.font = UIFont(name: "Times New Roman", size: 22)
        //        view.addSubview(thermoLabel)
        //        thermoLabel.snp.makeConstraints { maker in
        //            maker.right.equalToSuperview().inset(55)
        //            maker.top.equalToSuperview().inset(440)
        //        }
        
        //        //pressureView
        //        pressureView.image = UIImage(named: "pressure")
        //        view.addSubview(pressureView)
        //        pressureView.snp.makeConstraints { maker in
        //            maker.height.equalTo(70)
        //            maker.width.equalTo(70)
        //            maker.left.equalToSuperview().inset(80)
        //            maker.top.equalToSuperview().inset(480)
        //        }
        //
        //        //pressureLabel
        //        pressureLabel.text = "1021 hPa"
        //        pressureLabel.font = UIFont(name: "Times New Roman", size: 22)
        //        view.addSubview(pressureLabel)
        //        pressureLabel.snp.makeConstraints { maker in
        //            maker.left.equalToSuperview().inset(75)
        //            maker.top.equalToSuperview().inset(560)
        //        }
        
        //        //windSockView
        //        windSockView.image = UIImage(named: "windSock")
        //        view.addSubview(windSockView)
        //        windSockView.snp.makeConstraints { maker in
        //            maker.height.equalTo(70)
        //            maker.width.equalTo(70)
        //            maker.right.equalToSuperview().inset(80)
        //            maker.top.equalToSuperview().inset(480)
        //        }
        //
        //        //windSockLabel
        //        windSockLabel.text = "S"
        //        windSockLabel.font = UIFont(name: "Times New Roman", size: 22)
        //        view.addSubview(windSockLabel)
        //        windSockLabel.snp.makeConstraints { maker in
        //            maker.right.equalToSuperview().inset(75)
        //            maker.top.equalToSuperview().inset(560)
        //        }
        
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
    
    @objc func buttonShareTapped(_ sender: UIButton) {
        let url = URL(string: "https://www.apple.com")!
        UIApplication.shared.open(url, options: [:])
    }
    
}

