//
//  Data.swift
//  WeatherApp
//
//  Created by Sergio Mascarpone on 22.02.24.
//

import Foundation
import UIKit


class APiMAnager {
    
    static let shared:APiMAnager = APiMAnager()
    
    private let apiKey = "70b9166dc33204c62ee3c1e299ac88ee"

    func loadWeather(city: String, completion: @escaping (Result<WeatherApiGet?, Error>) -> Void) {
        guard let url = URL(string:"https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)")
        else { return }
        
        let session = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, responnse, error in
            if let error {
                completion(.failure(error))
            } else if let data {
                let weather = try? JSONDecoder().decode(WeatherApiGet.self, from: data)
                completion(.success(weather))
            }
           
        }
        
        session.resume()
    }
}
