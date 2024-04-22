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
    
    private var weatherData: [WeatherData] = [
        WeatherData(image: "sun", date: "23.12.2024 | 00:00", temperature: "10 °C", summary: "sun"),
        WeatherData(image: "sun", date: "23.12.2024 | 00:00", temperature: "12 °C", summary: "cloudy"),
        WeatherData(image: "sun", date: "23.12.2024 | 00:00", temperature: "12 °C", summary: "cloudy"),
        WeatherData(image: "sun", date: "23.12.2024 | 00:00", temperature: "8 °C", summary: "cloudy"),
        WeatherData(image: "sun", date: "23.12.2024 | 00:00", temperature: "12 °C", summary: "cloudy"),
        WeatherData(image: "sun", date: "23.12.2024 | 00:00", temperature: "12 °C", summary: "cloudy"),
        WeatherData(image: "sun", date: "23.12.2024 | 00:00", temperature: "12 °C", summary: "cloudy")
    ] // Структура для хранения данных о погоде
    
    struct WeatherData: Codable {
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
 
    private func updateWeatherData(_ weatherData: [WeatherData]) {
        self.weatherData = weatherData
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
        return weatherData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        let weather = weatherData[indexPath.row]
        cell.imageLabel.image = UIImage(named: weather.image)
        cell.updateDateTime()
        cell.temperatureLabel.text = weather.temperature
        cell.summaryLabel.text = weather.summary
        return cell
    }
}

class CustomCell: UITableViewCell {
    var imageLabel = UIImageView()
    var dateLabel = UILabel()
    var temperatureLabel = UILabel()
    var summaryLabel = UILabel()
    
    func updateDateTime() {
               let dateFormatter = DateFormatter()
               dateFormatter.dateFormat = "HH:mm"
               let timeString = dateFormatter.string(from: Date())
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
