//
//  WeatherWindView.swift
//  WeatherApp
//
//  Created by Sergio Mascarpone on 11.03.24.
//
import SnapKit
import UIKit

class WeatherWindView: UIView {
    var state: WeatherCase
    
    var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    var subtitle: UILabel = {
        let subtitle = UILabel()
        subtitle.text = " "
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
    
    func setupUI() {
        self.addSubview(image)
        self.addSubview(subtitle)
        
        image.snp.makeConstraints { maker in
            maker.height.equalTo(116)
            maker.width.equalTo(90)
            maker.centerX.equalToSuperview().offset(200)
            maker.top.equalToSuperview().inset(350)
        }
        
        subtitle.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview().offset(200)
            maker.top.equalToSuperview().inset(450)
        }
        image.image = state.image
    }
    
    func setupText(_ text: String) {
        self.subtitle.text = text
    }
}
