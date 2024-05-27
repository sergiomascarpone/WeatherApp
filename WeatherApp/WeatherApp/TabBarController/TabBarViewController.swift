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
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        //MARK: Используем задание зависимостей "из вне"
        let todayWeatherController = TodayViewController(presenter: TodayWeatherPresenter(weatherService: WeatherService())) //На скорую руку, но надеюсь суть понята
        let fiveDaysWeatherController = ForecastViewController()
        
        viewControllers = [
            createNavigationController(for: todayWeatherController, title: "Today", image: UIImage(systemName: "sun.max")), //Весь текст нужно будет вынести в локализацию
            createNavigationController(for: fiveDaysWeatherController, title: "Forecast", image: UIImage(systemName: "cloud.sun.rain")) //Локализация не касается названий картинок
        //Названия картинок можно вынести в константы
        ]
    }
    
    //MARK: Для отображения лейбл вверху есть специально придуманный UINavigationController, посмотри как работает.
    //MARK: Никаких костылей в виде лейбл прибитых к верху экрана!!!
    private func createNavigationController(for rootViewController: UIViewController,
                                            title: String,
                                            image: UIImage?) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        rootViewController.navigationItem.title = title
        return navigationController
    }
}
