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
    
    var aboutDict: NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupNavigationBar(title: "About Us")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Data
    func loadData() {
//        Alamofire.req
//        Alamofire.request(.GET, "http://icaew-admin.jiggieapp.com/api/about", parameters: nil, encoding: <#T##ParameterEncoding#>, headers: <#T##[String : String]?#>
    }
    
    // MARK: -  UITableviewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        cell.textLabel?.text = "test"
        
        return cell
    }
    
    // MARK: -  UITableviewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }

}
