//
//  WeatherApiGet.swift
//  WeatherApp
//
//  Created by Sergio Mascarpone on 27.02.24.
//

import Foundation

struct WeatherApiGet: Codable {
    let main: Main
    let wind: Wind
    let name: String
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
    let humidity: Int
    let feels_like: Double
}

struct Wind: Codable {
    let speed: Double
}

struct Weather: Codable {
    let main: String
}
