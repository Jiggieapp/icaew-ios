//
//  AboutViewController.swift
//  icaew
//
//  Created by Setiady Wiguna on 6/29/16.
//  Copyright © 2016 Jiggie. All rights reserved.
//

import UIKit
import Alamofire

class AboutViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var aboutDict: [String : AnyObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupNavigationBar(title: "About Us")
        self.tableView.tableFooterView = UIView()
        
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Data
    func loadData() {
        
        if let request = NetworkManager.request(.GET, "about") {
            request.responseJSON(completionHandler: { (response) in
                switch response.result {
                case .Success(let jsonResult):
                    print(jsonResult)
                    
                    if let jsonDict = jsonResult as? [String : AnyObject] {
                        if let data = jsonDict["data"] as? [String : AnyObject] {
                            print(data)
                        }
                    }
                    
                case .Failure(let error):
                    print(error)
                }
            })
        }
    }
    
    // MARK: -  UITableviewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let aboutDict = self.aboutDict {
            return aboutDict.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        cell.textLabel?.text = "test"
        
        return cell
    }
    
    // MARK: -  UITableviewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }

}
