//
//  TabBarControllerViewController.swift
//  WeatherApp
//
//  Created by Sergio Mascarpone on 27.02.24.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabs()
    }
   
    private func configureTabs() {
        let todayVC = TodayViewController()
        let forecastVC = ForecastViewController()
        
        todayVC.tabBarItem.image = UIImage(systemName: "sun.max")
        forecastVC.tabBarItem.image = UIImage(systemName: "cloud.sun.rain")
        
        todayVC.title = "Today"
        forecastVC.title = "Forecast"
        
        _ = UINavigationController(rootViewController: todayVC)
        _ = UINavigationController(rootViewController: forecastVC)
        
        tabBar.tintColor = .label
        tabBar.backgroundColor = .systemBackground
        
        setViewControllers([todayVC, forecastVC], animated: false)
    }
    
}
