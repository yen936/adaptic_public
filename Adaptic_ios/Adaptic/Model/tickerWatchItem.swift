//
//  watchItem.swift
//  Adaptic
//
//  Created by Benji Magnelli on 2/14/19.
//  Copyright © 2019 Benji Magnelli. All rights reserved.
//

import UIKit
import SwiftyJSON

//struct tickerWatchItem {
//    let ticker : String
//    let companyName: String
//    let currentPrice: Float
//    let percentChange: Float
//
//    init? (json: JSON) {
//        for number in 0...numberOfTickers - 1 {
//            let name = json[myTickers[number].uppercased()]["quote"]["companyName"].stringValue
//            let price = json[myTickers[number].uppercased()]["quote"]["latestPrice"].floatValue
//            let ticker = json[myTickers[number].uppercased()]["quote"]["symbol"].stringValue
//            let percentChange = json[myTickers[number].uppercased()]["quote"]["changePercent"].floatValue
//
//            self.ticker = ticker
//            self.companyName = name
//            self.percentChange = percentChange
//            self.currentPrice = price
//
//        }
//
//
//
//    }
//
//}

class tickerWatchItem {

    let ticker : String
    let companyName: String
    let currentPrice: Float
    let percentChange: Float
    
    

    init(tickerSymbol: String, compayName: String, currentPrice: Float, percentChange: Float) {
        self.ticker = tickerSymbol
        self.companyName = compayName
        self.currentPrice = currentPrice
        self.percentChange = percentChange
        

    }
}



