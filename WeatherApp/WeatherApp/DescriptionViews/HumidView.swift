//
//  HumidView.swift
//  WeatherApp
//
//  Created by Sergio Mascarpone on 29.02.24.
//

import UIKit
import SnapKit

class HumidView: TodayViewController {
    
    private lazy var humidView = UIImageView()
    private lazy var humidLabel = UILabel()
    private lazy var humidStackView = UIStackView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
    }
    
    func initialization() {
        
        //HumidStackView
        view.addSubview(humidStackView)
        humidStackView.backgroundColor = .systemPink
        humidStackView.snp.makeConstraints { maker in
            maker.height.equalTo(120)
            maker.width.equalTo(100)
            maker.left.equalToSuperview().inset(40)
            maker.top.equalToSuperview().inset(350)
        }
        
        //humidView
        humidView.image = UIImage(named: "humid")
        view.addSubview(humidView)
        humidView.snp.makeConstraints { maker in
            maker.height.equalTo(80)
            maker.width.equalTo(80)
        }
        
        //humidLabel
        humidLabel.text = "0 mm"
        humidLabel.font = UIFont(name: "Times New Roman", size: 22)
        view.addSubview(humidLabel)
        humidLabel.snp.makeConstraints { maker in
            maker.top.equalTo(humidView.snp.bottom).offset(0)
        }
    }
 
}


