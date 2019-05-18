//
//  watchListViewController.swift
//  Adaptic
//
//  Created by Benji Magnelli on 2/11/19.
//  Copyright © 2019 Benji Magnelli. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreData

var numberOfTickers : Int = 0
var myTickers : [String] = []

public let adapticLightPurple = UIColor(displayP3Red: 106/255, green: 127/255, blue: 219/255, alpha: 1)
public let adapticDarkPurple = UIColor(displayP3Red: 9/255, green: 12/255, blue: 155/255, alpha: 1)
public let adapticGreen = UIColor(displayP3Red: 88/255, green: 240/255, blue: 161/255, alpha: 1)
public let adapticRed = UIColor(displayP3Red: 249/255, green: 77/255, blue: 55/255, alpha: 1)

public let ALPHA_ADVANTAGE_API_KEY = "Insert your API Key"


class watchListViewController: UIViewController {
    
    let alphaAdvURL = "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=MSFT&apikey="
    var watchListBubbles : [tickerWatchItem] = []
    let dataModel = DataModel()
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var bottomBarView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting data for collectionView
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        
        
        //Editing the UI
        let nav = self.navigationController?.navigationBar
        nav?.isTranslucent = true
        nav?.backgroundColor = .clear
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        let origImage = UIImage(named: "search")
        let tintedImage = origImage?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        self.view.backgroundColor = adapticDarkPurple
        self.myCollectionView.backgroundColor = adapticDarkPurple
        searchButton.setImage(tintedImage, for: [])
        searchButton.tintColor = UIColor.white
        bottomBarView.layer.backgroundColor = adapticLightPurple.cgColor
        bottomBarView.layer.masksToBounds = false
        bottomBarView.layer.shadowColor = UIColor.black.cgColor
        bottomBarView.layer.shadowOpacity = 0.8
        bottomBarView.layer.shadowOffset = CGSize.zero
        bottomBarView.layer.shadowRadius = 5
        bottomBarView.layer.cornerRadius = 20
        
        
        //Gathering stored tickers
        dataModel.getStoredTickers()
        
        //Networking call with stored tickers
        var testString = ""
        for ticker in myTickers {
            testString = testString + ticker + ","
        }
        
        
        let testURL = "https://api.iextrading.com/1.0/stock/market/batch?symbols=\(testString)&types=quote"
        
        if myTickers.isEmpty == false {
            getCurrentPriceData(url: testURL, completion: {
                (data: [tickerWatchItem]?) in
                if let bubbles = data{
                    self.watchListBubbles = bubbles
                    DispatchQueue.main.async {
                        self.myCollectionView.reloadData()
                    }
                }

            })
        }
        else {
            self.myCollectionView.reloadData()
        }

        
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewDidLoad()
    }
    

    
    
    // MARK: - Networking
    // *************************************************
    
    func getCurrentPriceData(url: String, completion: @escaping (_ tickerData : [tickerWatchItem]?) -> Void)  {

        var tempArray : [tickerWatchItem] = []

        Alamofire.request(url, method: .get).responseJSON { response in
            if response.result.isSuccess {

                print("Sucesful JSON Grab")
               
                let equityPriceJSON = JSON(response.result.value!)
                

                
                for number in 0...numberOfTickers - 1 {
                    let name = equityPriceJSON[myTickers[number].uppercased()]["quote"]["companyName"].stringValue
                    let price = equityPriceJSON[myTickers[number].uppercased()]["quote"]["latestPrice"].floatValue
                    let ticker = equityPriceJSON[myTickers[number].uppercased()]["quote"]["symbol"].stringValue
                    let percentChange = equityPriceJSON[myTickers[number].uppercased()]["quote"]["change"].floatValue


                    let tickerBubble = tickerWatchItem(tickerSymbol: ticker, compayName: name, currentPrice: price, percentChange: percentChange)

                    tempArray.append(tickerBubble)
                }
                
                completion(tempArray)
                
            }

            else if response.result.isFailure {
                print("Error in getCurrentPriceData: \(String(describing: response.result.error))")
                completion(nil)
            }
        }


    }

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let priceViewController = segue.destination as? priceScreenViewController {
            if let stock = sender as? tickerWatchItem {
                priceViewController.stockWatchItem = stock
            }
        }
    }
    
}





extension watchListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return watchListBubbles.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let watchItem = watchListBubbles[indexPath.row]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "watchItem", for: indexPath) as? TickerCell
            else { return UICollectionViewCell() }
        cell.setData(watchItem: watchItem)
        
        cell.layer.backgroundColor = adapticDarkPurple.cgColor
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = adapticLightPurple.cgColor
        cell.layer.shadowOpacity = 0.8
        cell.layer.shadowOffset = CGSize.zero
        cell.layer.shadowRadius = 5
        cell.layer.cornerRadius = 20
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let bubble = watchListBubbles[indexPath.row]
        performSegue(withIdentifier: "showPriceScreen", sender: bubble)

    }
    
    
}

