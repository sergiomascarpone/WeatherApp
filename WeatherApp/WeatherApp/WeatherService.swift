//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Sergio Mascarpone on 2.04.24.

import Foundation
import SwiftyJSON
import Alamofire

public enum TypeOfWeatherRequest: String {
    case weather
    case forecast
}

final public class WeatherService {
    
    typealias WeatherDataCompletion = (_ weatherData: Data?, _ errorMessage: String?) -> ()
    typealias WeatherRequest = (_ forecasts: [ForecastDTO]?, _ errorMessage: String?) -> ()
    
    // MARK: - Helper Methods
    class func getResponse(type: TypeOfWeatherRequest, completion: @escaping WeatherRequest) {
        
        guard let latitudes = (UserDefaults.standard.object(forKey: Constants.latitudesKey.rawValue) as? Float),
              let longitudes = (UserDefaults.standard.object(forKey: Constants.longitudesKey.rawValue) as? Float) else {
            return
        }
        
        let forecastManager = WeatherService()
        forecastManager.forecastWeatherDataFor(type: type, lat: latitudes, lon: longitudes) { (response, error) in
            if let error = error {
                completion(nil, error)
            } else {
                guard let data = response else {
                    completion(nil, "No data response")
                    return
                }
                if type == .weather,
                   let forecastDTO = try? JSONDecoder().decode(ForecastDTO.self, from: data) {
                    completion([forecastDTO], nil)
                } else if type == .forecast,
                          let responseDTO = try? JSONDecoder().decode(ResponseDTO.self, from: data) {
                    let forecasts = responseDTO.forecasts
                    completion(forecasts, nil)
                    
                } else {
                    completion(nil, "JSON could not be serialized")
                }
            }
        }
    }
    
    // MARK: - Requesting Data
    func forecastWeatherDataFor(type: TypeOfWeatherRequest, lat: Float, lon: Float, completion: @escaping WeatherDataCompletion) {
        
        AF.request(APIRouter.getCurrentWeather(type, lat, lon)).responseData { response in
            switch response.result {
            case .success:
                guard let data = response.data else {
                    completion(nil, "No data response")
                    return
                }
                completion(data, nil)
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
}
