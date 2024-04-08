//
//  AnotherViewController.swift
//  WeatherApp
//
//  Created by Sergio Mascarpone on 3.04.24.
//

import UIKit

class TodayWeatherInfo: UIViewController {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var humidView: UIStackView!
    @IBOutlet weak var windyView: UIStackView!
    @IBOutlet weak var termometerView: UIStackView!
    @IBOutlet weak var pressureView: UIStackView!
    @IBOutlet weak var windSockView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
