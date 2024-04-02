//
//  APIRouter.swift
//  WeatherApp
//
//  Created by Sergio Mascarpone on 2.04.24.
//

import Foundation
import Alamofire

enum APIRouter {
    case getCurrentWeather(_ type: TypeOfWeatherRequest, _ lat: Float, _ lon: Float)
}

extension APIRouter {
    var baseURL: String {
        switch self {
        case .getCurrentWeather:
            return Constants.defaultURL.rawValue
        }
    }
    
    var path: String {
        switch self {
        case .getCurrentWeather(let type, let lat, let lon):
            return type.rawValue + "?lat=\(lat)&lon=\(lon)&appid=\(Constants.apiKey.rawValue)&units=metric"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getCurrentWeather:
            return .get
        }
    }
    
    var params: Parameters? {
        return nil
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }
}
