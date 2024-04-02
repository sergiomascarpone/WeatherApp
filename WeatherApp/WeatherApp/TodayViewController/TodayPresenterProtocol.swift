//
//  TodayPresenterProtocol.swift
//  WeatherApp
//
//  Created by Sergio Mascarpone on 27.02.24.
//

import Foundation

protocol TodayWeatherPresenterProtocol {
    var todayWeatherResultDelegate: TodayWeatherResultDelegate? { get set }
    func requestLocationIfNeeded()
    func defineWindDirection(degree: Int) -> String
}
