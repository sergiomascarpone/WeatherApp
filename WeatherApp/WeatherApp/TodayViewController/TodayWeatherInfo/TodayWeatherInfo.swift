//
//  AnotherViewController.swift
//  WeatherApp
//
//  Created by Sergio Mascarpone on 3.04.24.
//

import UIKit

class TodayWeatherInfo: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super .init(coder: aDecoder)
    }
    
    private func setupViews() {
        let xibView = loadViewFromXib()
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(xibView)
    }
    
    private func loadViewFromXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "TodayWeatherInfo", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first! as! UIView
    }
//    @IBOutlet var contentView: UIView!
//    @IBOutlet weak var humidView: UIStackView!
//    @IBOutlet weak var windyView: UIStackView!
//    @IBOutlet weak var termometerView: UIStackView!
//    @IBOutlet weak var pressureView: UIStackView!
//    @IBOutlet weak var windSockView: UIStackView!

}
