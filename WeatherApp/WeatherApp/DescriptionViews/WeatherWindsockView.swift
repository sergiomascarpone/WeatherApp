//
//  WeatherWindsockView.swift
//  WeatherApp
//
//  Created by Sergio Mascarpone on 11.03.24.
//
import SnapKit
import UIKit

class WeatherWindsockView: UIView {
    var state: WeatherCase
    
    var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    var subtitle: UILabel = {
        let subtitle = UILabel()
        subtitle.font = UIFont(name: "Times New Roman", size: 20)
        subtitle.text = ""
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
    
    func setupUI() {
        self.addSubview(image)
        self.addSubview(subtitle)
        
        image.snp.makeConstraints { maker in
            maker.height.equalTo(116)
            maker.width.equalTo(90)
            maker.left.equalToSuperview().inset(210)
            maker.top.equalToSuperview().inset(480)
        }
        
        subtitle.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(250)
            maker.top.equalToSuperview().inset(580)
        }
        image.image = state.image
    }
    
    func setupText(_ text: String) {
        self.subtitle.text = text
    }
}
