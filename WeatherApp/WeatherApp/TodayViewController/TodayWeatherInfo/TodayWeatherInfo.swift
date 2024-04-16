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
        self.initSubviews()
    }
   
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initSubviews()
    }

    func initSubviews() {
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: Bundle(for: type(of: self)))
        let contentView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
    func addConstraints() {
        self.snp.makeConstraints { make in
            make.left.right.bottom.top.equalTo(contentView)
        }
    }
}

//    func commonInit() {
//        let loadXibView = Bundle.main.loadNibNamed("contentView", owner: self, options: nil)![0] as! UIView
//        loadXibView.frame = self.bounds
//        addSubview(loadXibView)
//    }

//    func loadViewFromXib() -> UIView {
//        let bundle = Bundle(for: type(of: self))
//        let nib = UINib(nibName: "contentView", bundle: bundle)
//        return nib.instantiate(withOwner: self, options: nil).first! as! UIView
//    }
    

//override init(frame: CGRect) {
//       super.init(frame: frame)
//       commonInit()
//   }
//   
//   required init?(coder aDecoder: NSCoder) {
//       super.init(coder: aDecoder)
//       commonInit()
//   }
//   
//   private func commonInit() {
//       guard let view = loadViewFromNib() else { return }
//       view.frame = bounds
//       view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//       addSubview(view)
//   }
//   
//   private func loadViewFromNib() -> UIView? {
//       let nib = UINib(nibName: "TodayWeatherInfo", bundle: Bundle(for: type(of: self)))
//       return nib.instantiate(withOwner: self, options: nil).first as? UIView
//   }
//}
