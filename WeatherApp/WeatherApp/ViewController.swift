//
//  ViewController.swift
//  WeatherApp
//
//  Created by Sergio Mascarpone on 21.02.24.
//

import SnapKit
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
       
        
    }
    
    private func initialize() {
        view.backgroundColor = .cyan
        
        let label = UILabel()
        label.text = "Today"
        label.font = UIFont.systemFont(ofSize: 28)
        view.addSubview(label)
        label.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.top.equalToSuperview().inset(60)
    
        }
    }


}

