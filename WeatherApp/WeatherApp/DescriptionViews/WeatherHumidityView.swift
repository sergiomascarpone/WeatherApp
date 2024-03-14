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
        subtitle.text = " %"
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
            maker.height.equalTo(116)
            maker.width.equalTo(90)
            maker.left.equalToSuperview().inset(270)
            maker.top.equalToSuperview().inset(350)
        }
        
        subtitle.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(298)
            maker.top.equalToSuperview().inset(450)
        }
        image.image = state.image
    }
    
    private func setupText(_ text: String) {
        self.subtitle.text = text
    }
}
