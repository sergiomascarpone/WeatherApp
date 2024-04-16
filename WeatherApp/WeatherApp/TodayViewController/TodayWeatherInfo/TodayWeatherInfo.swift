//  AnotherViewController.swift
//  WeatherApp
//
//  Created by Sergio Mascarpone on 3.04.24.
//

import UIKit
import SnapKit

class TodayWeatherInfo: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var humidLabel: UILabel!
    @IBOutlet weak var windyLabel: UILabel!
    @IBOutlet weak var termometerLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windSockLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        loadViewFromXib()
//        commonInit()
//        self.initSubviews()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initSubviews()
    }
    
//    func commonInit() {
//        let loadXibView = Bundle.main.loadNibNamed("contentView", owner: self, options: nil)![0] as! UIView
//        loadXibView.frame = self.bounds
//        addSubview(loadXibView)
//    }
//
//    func loadViewFromXib() -> UIView {
//        let bundle = Bundle(for: type(of: self))
//        let nib = UINib(nibName: "contentView", bundle: bundle)
//        return nib.instantiate(withOwner: self, options: nil).first! as! UIView
//    }
    
    func initSubviews() {
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: Bundle(for: type(of: self)))
        nib.instantiate(withOwner: self, options: nil)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        self.addConstraints()
    }
    
    func addConstraints() {
        self.snp.makeConstraints { make in
            make.left.right.bottom.top.equalTo(contentView)
        }
    }
}
