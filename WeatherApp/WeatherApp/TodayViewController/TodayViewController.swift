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
    
    private lazy var imageView = UIImageView()
    private lazy var cityNameLocationLabel = UILabel()
    private lazy var temperatureLabel = UILabel()
   
    private lazy var shareButton = UIButton()
    
    //Views
    //    private lazy var TodayWeatherInfo: TodayWeatherInfo = {
    //        let info = TodayWeatherInfo
    //        return info
    //    }()
    
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
        view.addSubview(precipitation)
        view.addSubview(wind)
        view.addSubview(humidity)
        view.addSubview(pressure)
        view.addSubview(windSock)
        todayInitialize()
        //        getLocation()
        
        //Добавление CustomViewXIB на экран
//        if let customView = loadViewFromXib() {
//            view.addSubview(customView)
//            customView.frame = CGRect(x: 50, y: 50, width: 200, height: 200)
//        }
        
        weatherManager.fetchWeatherData { [weak self] weatherData in
            guard weatherData != nil else { return }
            
            DispatchQueue.main.async {
                self?.displayWeatherData(weatherData!)
            }
        }
    }
        //XIB.file
//    func loadViewFromXib() -> UIView? {
//        let bundle = Bundle(for: type(of: self))
//        let nib = UINib(nibName: "TodayWeatherInfo", bundle: bundle)
//        return nib.instantiate(withOwner: self, options: nil).first as? UIView
//    }
    
    // Изменение изображения в зависимости от погоды - пока не работает(
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
    //        case "overcast clouds":
    //            return "cloud"
    //        default:
    //            return "unknown_weather"
    //        }
    //    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.requestLocationIfNeeded()
    }
    
    
    // Вывод данных о погоде на экран
    func displayWeatherData(_ weatherData: WeatherData) {
        
        self.cityNameLocationLabel.text = "\(weatherData.name)"
        self.temperatureLabel.text = "\(weatherData.main.temp)°C | \(weatherData.weather.first?.description ?? "Unknown")"
        self.precipitation.subtitle.text = "\(weatherData.main.humidity) mm"
        self.wind.subtitle.text = "\(weatherData.wind.speed) km/h"
        self.humidity.subtitle.text = "\(weatherData.main.humidity) %"
        self.pressure.subtitle.text = "\(weatherData.main.pressure) hPa"
        self.windSock.subtitle.text = "\(weatherData.wind.deg)"
        
        self.imageView.image = UIImage(named: "sun")
    }
    
    //    //LocationManager
    //    private func getLocation() {
    //        LocationManager.shared.getCorrentLocation { location in
    //            print(String(describing: location))
    //        }
    //    }
    
    //MARK: - SetUpViews
    private func todayInitialize() {
        view.backgroundColor = .systemBackground
        
        //        //dateLabel
        //        let dateFormatter = DateFormatter()
        //        dateFormatter.dateStyle = .medium
        //        dateFormatter.timeStyle = .none
        //        dateFormatter.locale = Locale(identifier: "en_US")
        //
        //        let date = Date()
        //
        //        dateLabel.text = (dateFormatter.string(from: date))
        //        dateLabel.font = UIFont.systemFont(ofSize: 24)
        //        view.addSubview(dateLabel)
        //        dateLabel.snp.makeConstraints {
        //            $0.centerX.equalToSuperview()
        //            $0.top.equalToSuperview().inset(60)
        //        }
        
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
