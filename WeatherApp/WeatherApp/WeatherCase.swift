//
//  WeatherCase.swift
//  WeatherApp
//
//  Created by Sergio Mascarpone on 29.02.24.

import Foundation
import UIKit

enum WeatherCase {
    case precipitation
    case wind
    case humidity
    case pressure
    case windsock
    
    var image: UIImage! {
        switch self {
        case .precipitation:
            return UIImage(named: "precipitation")
        case .wind:
            return UIImage(named: "windySpeed")
        case .humidity:
            return UIImage(named: "humidity")
        case .pressure:
            return UIImage(named: "pressure")
        case .windsock:
            return UIImage(named: "windSock")
        }
    }
}
