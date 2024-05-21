//
//  TodayPresenter.swift
//  WeatherApp
//
//  Created by Sergio Mascarpone on 27.02.24.

import Foundation
import CoreLocation

protocol TodayWeatherResultDelegate: NSObjectProtocol {
    func toggleAlert(message: String)
    func updateWeatherData(weatherModel: ForecastDTO?)
}

final class TodayWeatherPresenter: NSObject, TodayWeatherPresenterProtocol {
    
    private let weatherService: WeatherService
    weak var todayWeatherResultDelegate: TodayWeatherResultDelegate?
    private let locationManager = CLLocationManager()
    
    init(weatherService: WeatherService) {
        self.weatherService = weatherService
        super.init()
        self.locationManager.delegate = self
    }
    
    func defineWindDirection(degree: Int) -> String {
        switch degree {
        case 0..<23: return "N"
        case 338..<360: return "N"
        case 23..<68: return "NE"
        case 68..<113: return "E"
        case 113..<168: return "SE"
        case 168..<203: return "S"
        case 203..<248: return "SW"
        case 248..<294: return "W"
        case 294..<338: return "NW"
        default: return ""
        }
    }
    
    func requestLocationIfNeeded() {
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse:
            locationRequest()
        case .denied:
            permissionDenied()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            if CLLocationManager.locationServicesEnabled()  {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
                    requestLocationIfNeeded()
                }
            }
        default:
            locationManager.requestAlwaysAuthorization()
        }
    }
}

extension TodayWeatherPresenter: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = locations.first?.coordinate else { return }
        
        UserDefaults.standard.set(Float(locValue.latitude), forKey: Constants.latitudesKey.rawValue)
        UserDefaults.standard.set(Float(locValue.longitude), forKey: Constants.longitudesKey.rawValue)
        
        WeatherService.getResponse(type: .weather) { [weak self] forecasts, errorMessage in
            if errorMessage != nil {
                self?.todayWeatherResultDelegate?.toggleAlert(message: errorMessage ?? "")
            } else if let weather = forecasts?.first {
                self?.todayWeatherResultDelegate?.updateWeatherData(weatherModel: weather)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.todayWeatherResultDelegate?.toggleAlert(message: "Failed to find user's location.")
    }
    
    func locationRequest() {
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.desiredAccuracy = kCLLocationAccuracyReduced
            self.locationManager.requestLocation()
        }
    }
    
    private func permissionDenied() {
        self.todayWeatherResultDelegate?.toggleAlert(message: "Location use was rejected. Change this in your phone settings.")
    }
}
