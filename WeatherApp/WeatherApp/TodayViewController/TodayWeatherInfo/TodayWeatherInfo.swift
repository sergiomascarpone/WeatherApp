//  AnotherViewController.swift
//  WeatherApp
//
//  Created by Sergio Mascarpone on 3.04.24.
//

import UIKit
import SnapKit

class TodayWeatherInfo: UIView {
    
    @IBOutlet var  weatherInfoView: UIView!
    @IBOutlet weak var humidLabel: UILabel!
    @IBOutlet weak var windyLabel: UILabel!
    @IBOutlet weak var termometerLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windSockLabel: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubviews()
//        self.addConstraints()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func initSubviews() {
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: Bundle(for: type(of: self)))
        nib.instantiate(withOwner: self, options: nil)
        weatherInfoView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(weatherInfoView)
//        self.addConstraints()
    }
    
//    private func addConstraints() {
//        self.snp.makeConstraints { make in
//            make.left.right.bottom.top.equalTo(weatherInfoView)
//        }
//    }
}

