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
        view.addSubview(label)
        label.snp.makeConstraints { maker in
            maker.left.equalToSuperview().inset(174)
            maker.top.equalToSuperview().inset(60)
    
        }
    }


}

