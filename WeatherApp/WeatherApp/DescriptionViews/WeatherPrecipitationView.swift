//
//  HumidView.swift
//  WeatherApp
//
//  Created by Sergio Mascarpone on 29.02.24.
//
import SnapKit
import UIKit

class WeatherPrecipitationView: UIView {
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
            maker.height.equalTo(116)
            maker.width.equalTo(90)
            maker.left.equalToSuperview().inset(40)
            maker.top.equalToSuperview().inset(350)
        }
        
        subtitle.text = "19 mm"
        subtitle.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(58)
            maker.top.equalToSuperview().inset(450)
        }
        image.image = state.image
    }
    
    private func setupText(_ text: String) {
        self.subtitle.text = text
    }
    
}
