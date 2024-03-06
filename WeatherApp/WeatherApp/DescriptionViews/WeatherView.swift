//
//  HumidView.swift
//  WeatherApp
//
//  Created by Sergio Mascarpone on 29.02.24.
//
import Foundation
import UIKit
import SnapKit

class WeatherView: UIView {
    
    private let state: WeatherCase
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var subtitle: UILabel = {
        let subtitle = UILabel()
        subtitle.font = UIFont(name: "Times New Roman", size: 22)
        subtitle.textColor = .systemBackground
        subtitle.textAlignment = .center
        return subtitle
    }()
    
    init(state: WeatherCase) {
        self.state = state
        super.init()
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
            maker.left.equalToSuperview().inset(40)
            maker.top.equalToSuperview().inset(350)
        }
        
        subtitle.snp.makeConstraints { maker in
//            maker.top.equalTo(humidView.snp.bottom).offset(0)
            maker.left.equalToSuperview().inset(55)
            maker.top.equalToSuperview().inset(440)
        }
        
        image.image = state.image
    }
    
    func setupText(_ text: String) {
        self.subtitle.text = text
    }
}

