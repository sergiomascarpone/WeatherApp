//
//  WeatherDTO.swift
//  WeatherApp
//
//  Created by Sergio Mascarpone on 27.02.24.
//

import Foundation
import Alamofire

class WeatherManager {
    
    let apiKey = "70b9166dc33204c62ee3c1e299ac88ee"
    
    func fetchWeatherData(completion: @escaping (WeatherData?) -> Void) {
        let url = "https://api.openweathermap.org/data/2.5/weather?q=Minsk&appid=\(apiKey)&units=metric"
        
        AF.request(url).responseDecodable(of: WeatherData.self) { response in
            if let weatherData = response.value {
                completion(weatherData)
            } else {
                completion(nil)
            }
        }
    }
    
}

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let wind: Wind
    let weather: [Weather]
    
    struct Main: Decodable {
        let temp: Double
        let humidity: Int
        let pressure: Double
    }
    
    struct Wind: Decodable {
        let speed: Double
        let deg: Int
    }
    
    struct Weather: Decodable {
        let description: String
    }
    
//    struct Pop: Decodable {
//        let pop: Double
//    }
}
