//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by Sergio Mascarpone on 22.02.24.
//
import SnapKit
import UIKit

// разабраться с таблицей...
class ForecastViewController: UIViewController {

    private lazy var forecastLabel = UITextField()
    private lazy var tableView = UITableView()
    //    private lazy var reuseIdentifier = "Forecast"
    
    private lazy var dayForecast = [
        WeatherDay(image: "today", date: "23.12.2024 | 0:00", temperature: "12 C", summary: "cloudy", weatherType: "cloud"),
        WeatherDay(image: "today", date: "23.12.2024 | 0:00", temperature: "12 C", summary: "rainy", weatherType: "rain"),
        WeatherDay(image: "today", date: "23.12.2024 | 0:00", temperature: "12 C", summary: "suny", weatherType: "sun"),
        WeatherDay(image: "today", date: "23.12.2024 | 0:00", temperature: "12 C", summary: "rainy", weatherType: "rain"),
        WeatherDay(image: "today", date: "23.12.2024 | 0:00", temperature: "12 C", summary: "rainy", weatherType: "rain"),
        WeatherDay(image: "today", date: "23.12.2024 | 0:00", temperature: "12 C", summary: "rainy", weatherType: "rain"),
        WeatherDay(image: "today", date: "23.12.2024 | 0:00", temperature: "12 C", summary: "rainy", weatherType: "rain"),
        WeatherDay(image: "today", date: "23.12.2024 | 0:00", temperature: "12 C", summary: "rainy", weatherType: "rain"),
        WeatherDay(image: "today", date: "23.12.2024 | 0:00", temperature: "12 C", summary: "rainy", weatherType: "rain"),
    ]
    
    private var timer: Timer?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTableView()
        forecastInitialize()
        
    }
    
    //MARK: - SetUpViews
    private func forecastInitialize() {
        
//        forecastLabel.text = "Forecast"
//        forecastLabel.font = UIFont.systemFont(ofSize: 24)
//        view.addSubview(forecastLabel)
//        forecastLabel.snp.makeConstraints { maker in
//            maker.centerX.equalToSuperview()
//            maker.top.equalToSuperview().inset(50)
//        }
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
    
    struct WeatherDay {
        var image: String
        var date: String
        var temperature: String
        var summary: String
        var weatherType: String
    }

}

//MARK: -
extension ForecastViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dayForecast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        let weatherDay = dayForecast[indexPath.row]
        cell.imageLabel.image = UIImage(named: weatherDay.image)
        cell.dateLabel.text = weatherDay.date
        cell.temperatureLabel.text = weatherDay.temperature
        cell.summaryLabel.text = weatherDay.summary
        // Установите изображение в зависимости от типа погоды
        cell.imageLabel.image = UIImage(named: weatherDay.weatherType)
        return cell
    }
}

class CustomCell: UITableViewCell {
    var imageLabel = UIImageView()
    var dateLabel = UILabel()
    var temperatureLabel = UILabel()
    var summaryLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(imageLabel)
        addSubview(dateLabel)
        addSubview(temperatureLabel)
        addSubview(summaryLabel)
        imageLabel.frame = CGRect(x: 20, y: 10, width: 50, height: 50)
        dateLabel.frame = CGRect(x: 100, y: 10, width: 140, height: 20)
        temperatureLabel.frame = CGRect(x: 300, y: 25, width: 150, height: 25)
        summaryLabel.frame = CGRect(x: 100, y: 20, width: 120, height: 60)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Error")
    }
}



//
//let weatherManager = WeatherManager()
//   var weatherData: [WeatherData] = []
//   
//   override func viewDidLoad() {
//       super.viewDidLoad()
//       
//       weatherManager.fetchWeatherData { [weak self] weatherData in
//           guard let weatherData = weatherData else { return }
//           
//           self?.weatherData = weatherData
//           DispatchQueue.main.async {
//               self?.tableView.reloadData()
//           }
//       }
//   }
//   
//   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//       return weatherData.count
//   }
//   
//   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//       let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath)
//       let data = weatherData[indexPath.row]
//       
//       let dateTime = NSDate(timeIntervalSince1970: data.dt)
//       let dateFormatter = DateFormatter()
//       dateFormatter.dateFormat = "HH:mm"
//       cell.textLabel?.text = dateFormatter.string(from: dateTime as Date)
//       cell.detailTextLabel?.text = "\(data.main.temp)°C"
//       
//       return cell
//   }
//
//
