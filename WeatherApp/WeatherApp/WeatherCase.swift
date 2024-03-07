//
//  WeatherCase.swift
//  WeatherApp
//
//  Created by Sergio Mascarpone on 29.02.24.

import Foundation
import UIKit

enum WeatherCase {
    case humid
    case wind
    case temperature
    case pressure
    case windsock
    
    var image: UIImage! {
        switch self {
        case .humid:
            return UIImage(named: "humid")
        case .wind:
            return UIImage(named: "windySpeed")
        case .temperature:
            return UIImage(named: "temperature")
        case .pressure:
            return UIImage(named: "pressure")
        case .windsock:
            return UIImage(named: "windSock")
        }
    }
}
