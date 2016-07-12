//
//  EventListViewController.swift
//  icaew
//
//  Created by Mohammad Nuruddin Effendi on 7/12/16.
//  Copyright © 2016 Jiggie. All rights reserved.
//

import UIKit

private let kEventListCellIdentifier = "kEventListCellIdentifier"

class EventListViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationBar(title: "EVENT IN "+"INDONESIA")
        
        self.setupView()
        self.loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: View
    private func setupView() {
        self.tableView.tableFooterView = UIView()
        self.tableView.registerNib(ProgrammesTableViewCell.nib(),
                                   forCellReuseIdentifier: kEventListCellIdentifier)
    }
    
    // MARK: Data
    private func loadData() {
        
    }
    
    // MARK: UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kEventListCellIdentifier) as! ProgrammesTableViewCell
        cell.selectionStyle = .None
        
        cell.roundedView.backgroundColor = UIColor(hexString: "05D3BB")
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
