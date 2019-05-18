//
//  priceScreenViewController.swift
//  
//
//  Created by Benji Magnelli on 2/11/19.
//

import UIKit
import Alamofire
import SwiftyJSON
import Charts
import SwiftCharts


class priceScreenViewController: UIViewController, ChartViewDelegate {
    
    
    @IBOutlet weak var chartViewOutlet: UIView!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var tickerOutlet: UILabel!
    @IBOutlet weak var currentPriceOutlet: UILabel!
    @IBOutlet weak var historicalDot: UIView!
    @IBOutlet weak var predictionDot: UIView!
    
    
    var stockWatchItem : tickerWatchItem?
    
    let baseURL = "https://api.iextrading.com/1.0/stock/"
    var threeMonthDataUrl = "/chart/3m"
    var oneMonthDateURL = "/chart/1m"
    var sixMonthDateURL = "/chart/6m"
    var yearDateURL = "/chart/1y"
    var twoYearDateURL = "/chart/2y"
    var oneDayDateURL = "/chart/1d"
    
    
    //let watchListSymbols = StoredTickers()
    
    var datesArray = [String]()
    var priceValueArrayCharting = [(Double, Double)]()
    var priceArray = [Double]()
    var predictionArrayCharting = [(Double, Double)]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        threeMonthDataUrl = baseURL + stockWatchItem!.ticker + threeMonthDataUrl
        
        self.view.backgroundColor = adapticDarkPurple

        
        chartViewOutlet.layer.backgroundColor = adapticDarkPurple.cgColor
        chartViewOutlet.layer.shadowColor = adapticLightPurple.cgColor
        chartViewOutlet.layer.shadowOpacity = 1
        chartViewOutlet.layer.shadowOffset = CGSize.zero
        chartViewOutlet.layer.shadowRadius = 5
        chartViewOutlet.layer.cornerRadius = 20
        
        historicalDot.layer.backgroundColor = adapticLightPurple.cgColor
        historicalDot.layer.shadowColor = UIColor.lightGray.cgColor
        historicalDot.layer.shadowOpacity = 1
        historicalDot.layer.shadowOffset = CGSize.zero
        historicalDot.layer.shadowRadius = 5
        historicalDot.layer.cornerRadius = 5
        
        predictionDot.layer.backgroundColor = adapticGreen.cgColor
        predictionDot.layer.shadowColor = UIColor.lightGray.cgColor
        predictionDot.layer.shadowOpacity = 1
        predictionDot.layer.shadowOffset = CGSize.zero
        predictionDot.layer.shadowRadius = 5
        predictionDot.layer.cornerRadius = 5
        
        getMonthPriceData(url: threeMonthDataUrl)
        setPassedDate()
        getPrediction(ticker: stockWatchItem!.ticker)
        
    }
    

    
    
    //MARK: - Charting
    /***************************************************************/
    
    func chartingPriceData(dateArray: [String], priceValueArrayCharting: [(Double, Double)]) {
        
        //this determines the range the x axis should be on
        let XAxisCount = Double(dateArray.count + 10)
        let minimumValue = priceArray.min()
        let maxiumumValue = priceArray.max()
        
        
        let chartConfig = ChartConfigXY(
            xAxisConfig: ChartAxisConfig(from: 0, to: XAxisCount, by: 1),
            yAxisConfig: ChartAxisConfig(from: (minimumValue!  - 2), to: (maxiumumValue! + 2), by: 0.1)
            
        )
        
        let frame = CGRect(x: -50, y: 0, width: 370, height: 370)
        
        let chart = LineChart(
            frame: frame,
            chartConfig: chartConfig,
            xTitle: "",
            yTitle: "Dates",
            lines: [(chartPoints: priceValueArrayCharting, color: adapticLightPurple), (chartPoints: predictionArrayCharting, color: adapticGreen), ]
        )
        
        
        self.chartViewOutlet.addSubview(chart.view)
    
    }
    
    
  
    
    
    //MARK: - Networking
    /***************************************************************/
    
    func setPassedDate() {
        let currentPrice = String(stockWatchItem!.currentPrice)
        //companyName.text = stockWatchItem?.companyName
        tickerOutlet.text = stockWatchItem?.ticker
        currentPriceOutlet.text = currentPrice
    
        
    }
    
    
    func getMonthPriceData(url: String){
        Alamofire.request(url, method: .get).responseJSON { response in
            if response.result.isSuccess {
                
                let monthDataJSON : JSON = JSON(response.result.value!)
                
                self.getClosePrice(jsonData: monthDataJSON)
                
            }
                
            else if response.result.isFailure {
                print("Error: \(String(describing: response.result.error))")
            }
        }
        
    }
    
    func getPrediction(ticker: String){
        
        let url = "Insert your own hosting URI"
        let params = ["tickers": ticker]
        
        Alamofire.request(url,method: .post, parameters: params).responseJSON { response in
                if response.result.isSuccess {
                                
                    let prediction : JSON = JSON(response.result.value!)
                    self.parsePrediction(prediction: prediction)
                }
                
                else if response.result.isFailure {
                    print("Error: \(String(describing: response.result.error))")
                    }
        }
        
    }
    
    
    //MARK: - JSON Parsing
    // *************************************************************
   
    func getClosePrice(jsonData: JSON)  {
        
        for object in 0..<(jsonData.count) {
            let closeValue = jsonData[object]["close"].doubleValue
            let dates = jsonData[object]["date"].stringValue
            
            priceArray.append(closeValue)
            
            let pair = (Double(object), closeValue)
            datesArray.append(dates)
            priceValueArrayCharting.append(pair)
        }
        
        
    }

    
    func parsePrediction (prediction: JSON) {
        let last = datesArray.count
        for object in 0..<(prediction.count) {
            
            let pair = (Double(object + last), prediction[object].doubleValue)
            
            predictionArrayCharting.append(pair)
            
        }
        
        chartingPriceData(dateArray: datesArray, priceValueArrayCharting: priceValueArrayCharting)
    }



}


