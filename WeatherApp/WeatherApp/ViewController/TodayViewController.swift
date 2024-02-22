//
//  ViewController.swift
//  WeatherApp
//
//  Created by Sergio Mascarpone on 21.02.24.
//

import SnapKit
import UIKit

class TodayViewController: UIViewController {
    
    private lazy var dateLabel = UILabel()
    private lazy var imageView = UIImageView()
    private lazy var cityNameLocationLabel = UILabel()
    private lazy var descriptionLabel = UILabel()
    private lazy var humidView = UIImageView()
    private lazy var windSpeedView = UIImageView()
    private lazy var thermoView = UIImageView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
       
        
    }
    
    private func initialize() {
        view.backgroundColor = .cyan
        
        //dateLabel
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
         
        let date = Date()
         
        dateLabel.text = (dateFormatter.string(from: date))
        dateLabel.font = UIFont.systemFont(ofSize: 24)
        view.addSubview(dateLabel)
        dateLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(60)
        }

        //imageView
        humidView.image = UIImage(systemName: "humidity.fill")
        view.addSubview(humidView)
        humidView.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.top.equalToSuperview().inset(100)
        }
        
    }


}

