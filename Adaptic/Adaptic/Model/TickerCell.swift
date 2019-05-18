//
//  TickerCell.swift
//  Adaptic
//
//  Created by Benji Magnelli on 3/7/19.
//  Copyright © 2019 Benji Magnelli. All rights reserved.
//

import UIKit

class TickerCell: UICollectionViewCell {

    
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var currentPrice: UILabel!
    @IBOutlet weak var tickerSymbol: UILabel!
    @IBOutlet weak var percentChange: UILabel!
    @IBOutlet weak var changeTriangle: UIImageView!
    
    func setData(watchItem: tickerWatchItem){
        
        companyName.text = watchItem.companyName
        currentPrice.text = String(watchItem.currentPrice)
        tickerSymbol.text = watchItem.ticker
        percentChange.text = String(format: "%.2f", watchItem.percentChange)
        
        if watchItem.percentChange > 0 {
            changeTriangle.image = UIImage(named: "ic_arrow_drop_up")
        }
        else if watchItem.percentChange < 0 {
            changeTriangle.image = UIImage(named: "ic_arrow_drop_down")
        }
        
        
    }
    
    
    
}
