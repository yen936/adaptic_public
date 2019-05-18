//
//  searchScreenViewController.swift
//  Adaptic
//
//  Created by Benji Magnelli on 2/11/19.
//  Copyright © 2019 Benji Magnelli. All rights reserved.
//

import UIKit
import SwiftEntryKit
import Alamofire
import SwiftyJSON

class searchViewController: UIViewController {
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addTextField: UITextField!
    @IBOutlet weak var removeTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var removeButton: UIButton!
    
    
    
    let dataModel = DataModel()
    var searchJSON : JSON = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //search(keywords: "ap")
        updateUI()
        
        
        tableView.isHidden = true
        
    }
    
    @IBAction func addButton(_ sender: Any) {
        dataModel.saveTicker(ticker: addTextField.text!)
        popupAdded(tickerName: addTextField.text!)
    }
    
    @IBAction func removeButton(_ sender: Any) {
        dataModel.deleteTicker(ticker: removeTextField.text!)
        popupDeleted(tickerName: removeTextField.text!)
    }

    
    
    func updateUI() {
        addButton.layer.cornerRadius = 15
        addButton.layer.backgroundColor = adapticLightPurple.cgColor
        
        removeButton.layer.cornerRadius = 15
        removeButton.layer.backgroundColor = adapticLightPurple.cgColor
        
        self.view.backgroundColor = adapticDarkPurple

    }
    
    
    func popupAdded(tickerName: String) {
        // Customized view
        let widthConstraint = EKAttributes.PositionConstraints.Edge.ratio(value: 0.7)
        let heightConstraint = EKAttributes.PositionConstraints.Edge.ratio(value: 0.5)
        
        // Attributes struct that describes the display, style, user interaction and animations of customView.
        var attributes = EKAttributes.topFloat
        attributes.name = "Added"
        attributes.positionConstraints.size = .init(width: widthConstraint, height: heightConstraint)
        attributes.windowLevel = .normal
        attributes.entryBackground = .color(color: adapticLightPurple)
        attributes.screenBackground = .color(color: UIColor(white: 0.5, alpha: 0.5))
        attributes.roundCorners = .all(radius: 15)
        attributes.displayDuration = 2
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.2, radius: 10, offset: .zero))
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.2), scale: .init(from: 1, to: 0.7, duration: 0.7)))
        
        
        let defaultStyle = EKProperty.LabelStyle(font: UIFont.systemFont(ofSize: 20), color: UIColor.white)
        
        
        let title = EKProperty.LabelContent(text: "Ticker: \(tickerName.uppercased())", style: defaultStyle)
        let desciption = EKProperty.LabelContent(text: "has been added", style: EKProperty.LabelStyle(font: UIFont.systemFont(ofSize: 15), color: UIColor.lightText))
        

        let simpleMessage = EKSimpleMessage(title: title, description: desciption)
        let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)
        let contentView = EKNotificationMessageView(with: notificationMessage)
        
        
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    
    func popupDeleted(tickerName : String) {
        // Customized view
        let widthConstraint = EKAttributes.PositionConstraints.Edge.ratio(value: 0.7)
        let heightConstraint = EKAttributes.PositionConstraints.Edge.ratio(value: 0.5)
        
        // Attributes struct that describes the display, style, user interaction and animations of customView.
        var attributes = EKAttributes.topFloat
        attributes.name = "Deleted"
        attributes.positionConstraints.size = .init(width: widthConstraint, height: heightConstraint)
        attributes.windowLevel = .normal
        attributes.entryBackground = .color(color: adapticLightPurple)
        attributes.screenBackground = .color(color: UIColor(white: 0.5, alpha: 0.5))
        attributes.roundCorners = .all(radius: 15)
        attributes.displayDuration = 2
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.2, radius: 10, offset: .zero))
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.2), scale: .init(from: 1, to: 0.7, duration: 0.7)))
        
        
        let defaultStyle = EKProperty.LabelStyle(font: UIFont.systemFont(ofSize: 20), color: UIColor.white)
        
        
        let title = EKProperty.LabelContent(text: "Ticker: \(tickerName.uppercased()) ", style: defaultStyle)
        let desciption = EKProperty.LabelContent(text: "has been removed", style: EKProperty.LabelStyle(font: UIFont.systemFont(ofSize: 15), color: UIColor.lightText))
        
        
        let simpleMessage = EKSimpleMessage(title: title, description: desciption)
        let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)
        let contentView = EKNotificationMessageView(with: notificationMessage)
        
        
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
    
    
    
    func search(keywords : String) {
        
        let url = "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(keywords)&apikey=\(ALPHA_ADVANTAGE_API_KEY)"
        
        
        Alamofire.request(url, method: .get).responseJSON { response in
            if response.result.isSuccess {
                
                print("Sucesful JSON Grab")
                self.searchJSON = JSON(response.result.value!)
            }
            
            if response.result.isFailure{
                
                print("Failure to Search")
                
            }
    
        }
        
    }
    
   
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}



