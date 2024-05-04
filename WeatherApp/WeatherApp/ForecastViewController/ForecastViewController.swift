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
//            let weather = self.weatherList[indexPath.row]
//            let imageName = self.weatherImageNameTableView(for: weather.summary)
            cell.imageLabel.image = UIImage(named: self.weatherImageNameTableView(for: weatherData.weather.first?.description ?? ""))
            cell.updateDateTime()
            cell.temperatureLabel.text = "\(weatherData.main.temp) °C"
            
            cell.summaryLabel.text = "\(weatherData.weather.first?.description ?? "Unknown")"
        }
        return cell
    }

//    // Проверка, является ли время в интервале в 3 часа
//    func is3HourInterval(_ dateString: String) -> Bool {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd.MM.yyyy | HH:mm"
//        
//        guard let date = dateFormatter.date(from: dateString) else {
//            return false // Возвращаем false, если не удалось получить дату из строки
//        }
//        
//        // Получаем текущую дату и время
//        let currentDate = Date()
//        
//        // Вычисляем разницу во времени между текущим временем и временем из строки
//        let timeDifference = currentDate.timeIntervalSince(date)
//        
//        // Проверяем, находится ли время в интервале в 3 часа
//        return timeDifference.truncatingRemainder(dividingBy: 3 * 3600) == 0
//    }
    
    class CustomCell: UITableViewCell {
        var imageLabel = UIImageView()
        var dateLabel = UILabel()
        var temperatureLabel = UILabel()
        var summaryLabel = UILabel()
        
        func updateDateTime() {
            var currentDate = Date()
            let calendar = Calendar.current
            
            currentDate = calendar.date(byAdding: .hour, value: 3, to: currentDate) ?? Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let timeString = dateFormatter.string(from: currentDate)
            let dateString = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .none) // Получаем текущую дату
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
