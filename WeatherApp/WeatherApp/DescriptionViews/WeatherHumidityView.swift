//
//  WeatherTemperatureView.swift
//  WeatherApp
//
//  Created by Sergio Mascarpone on 11.03.24.
//

import SnapKit
import UIKit

class WeatherHumidityView: UIView {
    private let state: WeatherCase
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var subtitle: UILabel = {
        let subtitle = UILabel()
        subtitle.font = UIFont(name: "Times New Roman", size: 20)
        subtitle.textColor = .black
        subtitle.textAlignment = .center
        return subtitle
    }()
    
    init(state: WeatherCase) {
        self.state = state
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubview(image)
        self.addSubview(subtitle)
        
        image.snp.makeConstraints { maker in
            maker.height.equalTo(80)
            maker.width.equalTo(80)
            maker.right.equalToSuperview().inset(40)
            maker.top.equalToSuperview().inset(350)
        }
        
        subtitle.text = "69 %"
        subtitle.snp.makeConstraints { maker in
            maker.right.equalToSuperview().inset(55)
            maker.top.equalToSuperview().inset(440)
        }
    }
}
