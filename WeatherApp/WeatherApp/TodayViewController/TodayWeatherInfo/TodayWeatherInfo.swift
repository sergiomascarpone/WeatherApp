//
//  AnotherViewController.swift
//  WeatherApp
//
//  Created by Sergio Mascarpone on 3.04.24.
//

import UIKit

class TodayWeatherInfo: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var humidView: UIStackView!
    @IBOutlet weak var humidLabel: UILabel!
    @IBOutlet weak var windyView: UIStackView!
    @IBOutlet weak var windyLabel: UILabel!
    @IBOutlet weak var termometerView: UIStackView!
    @IBOutlet weak var termometerLabel: UILabel!
    @IBOutlet weak var pressureView: UIStackView!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windSockView: UIStackView!
    @IBOutlet weak var windSockLabel: UILabel!
    
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
}
