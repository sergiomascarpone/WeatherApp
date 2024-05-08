//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by Sergio Mascarpone on 22.02.24.
//
import SnapKit
import UIKit
import Alamofire

class ForecastViewController: UIViewController {
    
    private lazy var forecastLabel = UITextField()
    private lazy var tableView = UITableView()
    private var initialDate = Date() // Первоначальная дата и время
    private let timeInterval: TimeInterval = 3 * 60 * 60 // Смещение времени на 3 часа
       
    
    private var weatherList: [WeatherTableList] = [
        WeatherTableList(image: " ", date: "23.12.2024 | 00:00", temperature: "°C", summary: " "),
        WeatherTableList(image: " ", date: "23.12.2024 | 00:00", temperature: "°C", summary: " "),
        WeatherTableList(image: " ", date: "23.12.2024 | 00:00", temperature: "°C", summary: " "),
        WeatherTableList(image: " ", date: "23.12.2024 | 00:00", temperature: "°C", summary: " "),
        WeatherTableList(image: " ", date: "23.12.2024 | 00:00", temperature: "°C", summary: " "),
        WeatherTableList(image: " ", date: "23.12.2024 | 00:00", temperature: "°C", summary: " "),
        WeatherTableList(image: " ", date: "23.12.2024 | 00:00", temperature: "°C", summary: " ")
    ]
    
    struct WeatherTableList: Codable {
        var image: String
        var date: String
        var temperature: String
        var summary: String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTableView()
        forecastInitialize()
    }
    
    // Изменение изображения в зависимости от погоды - работает)
    func weatherImageNameTableView(for weatherDescription: String) -> String {
        switch weatherDescription.lowercased() {
        case let str where str.contains("clear"): return "sun"
        case let str where str.contains("overcast clouds"): return "cloud"
        case let str where str.contains("clouds"): return "cloudyDay"
        case let str where str.contains("snow"): return "snowing"
        case let str where str.contains("rain"): return "rain"
        default: return "unknown"
        }
    }
    
    private func updateWeatherData(_ weatherData: [WeatherTableList]) {
        self.weatherList = weatherData
        self.tableView.reloadData()
    }
    
    //MARK: - SetUpViews
    private func forecastInitialize() {
        forecastLabel.font = UIFont.systemFont(ofSize: 24)
        view.addSubview(forecastLabel)
        forecastLabel.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.top.equalToSuperview().inset(50)
        }
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 80
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.top.equalToSuperview().inset(100)
            make.bottom.equalToSuperview().inset(80)
        }
    }
}

extension ForecastViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        
        let apiKey = "70b9166dc33204c62ee3c1e299ac88ee"
        let url = ("https://api.openweathermap.org/data/2.5/weather?q=Minsk&appid=\(apiKey)&units=metric")
        
        AF.request(url).responseDecodable(of: WeatherData.self) { response in
            guard let weatherData = response.value else { return }
            let newDate = Calendar.current.date(byAdding: .second, value: Int(self.timeInterval * Double(indexPath.row)), to: self.initialDate) ?? Date()
//            let weather = self.weatherList[indexPath.row]
//            let imageName = self.weatherImageNameTableView(for: weather.summary)
            cell.imageLabel.image = UIImage(named: self.weatherImageNameTableView(for: weatherData.weather.first?.description ?? ""))
            cell.updateDateTime(with: newDate)
            cell.temperatureLabel.text = "\(weatherData.main.temp) °C"
            
            cell.summaryLabel.text = "\(weatherData.weather.first?.description ?? "Unknown")"
        }
        return cell
    }

    
    class CustomCell: UITableViewCell {
        var imageLabel = UIImageView()
        var dateLabel = UILabel()
        var temperatureLabel = UILabel()
        var summaryLabel = UILabel()
        
        func updateDateTime(with date: Date) {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                let timeString = dateFormatter.string(from: date)
                let dateString = DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .none)
                dateLabel.text = dateString + " | " + timeString
            }
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            addSubview(imageLabel)
            addSubview(dateLabel)
            addSubview(temperatureLabel)
            addSubview(summaryLabel)
            imageLabel.frame = CGRect(x: 20, y: 10, width: 50, height: 50)
            dateLabel.frame = CGRect(x: 100, y: 10, width: 180, height: 20)
            temperatureLabel.frame = CGRect(x: 300, y: 25, width: 150, height: 25)
            summaryLabel.frame = CGRect(x: 100, y: 40, width: 180, height: 20)
        }
        
        required init?(coder: NSCoder) {
            fatalError("Error")
        }
    }
}
