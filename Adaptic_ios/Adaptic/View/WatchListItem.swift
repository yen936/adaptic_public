//
//  WatchListItem.swift
//  Adaptic
//
//  Created by Benji Magnelli on 2/18/19.
//  Copyright © 2019 Benji Magnelli. All rights reserved.
//
//
//import Foundation
//import UIKit
//
//class WatchListItem: UIView {
//
//    let newView = UIView(frame: CGRect(x: 36, y: 400, width: 302, height: 128))
//    let name = UILabel(frame: CGRect(x: 17, y: 11, width: 227, height: 41))
//    let ticker = UILabel(frame: CGRect(x: 17, y: 89, width: 84, height: 24))
//    let change = UILabel(frame: CGRect(x: 185, y: 89, width: 52, height: 24))
//    let price = UILabel(frame: CGRect(x: 33, y: 52, width: 134, height: 24))
//    let dollars = UILabel(frame: CGRect(x: 17, y: 52, width: 14, height: 24))
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.updateUI()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func updateUI() {
//
//        newView.layer.backgroundColor = UIColor.white.cgColor
//        newView.layer.shadowColor = UIColor.lightGray.cgColor
//        newView.layer.shadowOpacity = 1
//        newView.layer.shadowOffset = CGSize.zero
//        newView.layer.shadowRadius = 5
//        newView.layer.cornerRadius = 20
//
//
//        name.textColor = .black
//        name.textAlignment = .left
//        name.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
//        name.text = "Company Name"
//
//
//        ticker.textColor = .black
//        ticker.textAlignment = .left
//        ticker.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.regular)
//        ticker.text = "TOCKER"
//
//
//        change.textAlignment = .left
//        change.textColor = .black
//        change.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.regular)
//        change.text = "10.99"
//
//
//        price.textAlignment = .right
//        price.textColor = .black
//        price.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
//        price.text = "1,000,000.00"
//
//
//        dollars.textColor = .black
//        dollars.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
//        dollars.text = "$"
//
//        newView.addSubview(name)
//        newView.addSubview(ticker)
//        newView.addSubview(change)
//        newView.addSubview(price)
//        newView.addSubview(dollars)
//
//        self.addSubview(newView)
//    }
//
//
//}
