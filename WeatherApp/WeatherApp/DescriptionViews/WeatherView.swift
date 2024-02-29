//
//  HumidView.swift
//  WeatherApp
//
//  Created by Sergio Mascarpone on 29.02.24.
//

import UIKit
import SnapKit

//class WeatherView: UIView {
//    
//    func configure(with info: WeatherViewInfo) {
//        
//    }
//    
//    init() {
//        super .init(frame: .zero)
//        initialize()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private var humidImageView: UIImageView = {
//        let view = UIImageView()
//        view.image = UIImage(named: "humid")
//        return view
//    }()
//    
//    private let humidLabel: UILabel = {
//        let label = UILabel()
//        label.text = "0 mm"
//        label.font = UIFont(name: "Times New Roman", size: 22)
//        return label
//    }()
//}
//
//private extension WeatherView {
//    func initialize() {
//        backgroundColor = .cyan
//        let yStack = UIStackView()
//        yStack.axis = .vertical
//        yStack.addArrangedSubview(humidImageView)
//        yStack.addArrangedSubview(humidLabel)
//    }
//}






















//class WeatherView: UIView {
//    
//    private let state: WeatherCase
//    
//    private lazy var image: UIImageView = {
//        let image = UIImageView()
//        image.contentMode = .scaleToFill
//        return image
//    }()
//    
//    private lazy var subtitle: UILabel = {
//        let subtitle = UILabel()
//        subtitle.text = "0 mm"
//        subtitle.font = UIFont(name: "Times New Roman", size: 22)
//        subtitle.textColor = .systemBackground
//        return subtitle
//    }()
//    
//    init(state: WeatherCase) {
//        self.state = state
//        setupUI()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupUI() {
//        self.addSubview(image)
//        self.addSubview(subtitle)
//        
//        image.snp.makeConstraints { maker in
//            maker.height.equalTo(80)
//            maker.width.equalTo(80)
//            maker.left.equalToSuperview().inset(40)
//            maker.top.equalToSuperview().inset(350)
//        }
//        
//        subtitle.snp.makeConstraints { maker in
//            maker.left.equalToSuperview().inset(55)
//            maker.top.equalToSuperview().inset(440)
//        }
//        image.image = state.image
//    }
//    func setupText(_ text: String) {
//        self.subtitle.text = text
//    }
//    
//}


