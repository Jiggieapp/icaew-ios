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
    
    private var country: Country!
    private var events: [Event]?
    
    
    convenience init(country: Country) {
        self.init(nibName: "EventListViewController", bundle: nil)
        self.country = country
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationBar(title: "EVENTS IN "+country.name.uppercaseString)
        
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
        self.showHUD()
        Event.retrieveEvents(countryId: self.country.id) { (result) in
            switch result {
            case .Success(let events):
                self.events = events
                self.tableView.reloadData()
                
            case .Error(_):
                break
            }
            
            self.dismissHUD()
        }
    }
    
    // MARK: UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        guard let events = self.events else {
            return 0
        }
        
        return events.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kEventListCellIdentifier) as! ProgrammesTableViewCell
        cell.selectionStyle = .None
        
        cell.roundedView.backgroundColor = UIColor(hexString: "05D3BB")
        
        if let events = self.events {
            let event = events[indexPath.section]
            
            let date = NSDate.dateFromString("yyyy-MM-dd HH:mm:ss", string: event.startDate)
            
            if let date = date,
                stringDate = NSDate.stringFromDate(date, format: "MMM dd") {
                let startDate = stringDate.stringByReplacingOccurrencesOfString(" ", withString: "\n")
                cell.initialLabel.text = startDate
            }
            
            cell.titleLabel.text = event.title
        }
        
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
        
        if let events = self.events {
            self.removeBackButtonTitle()
            self.navigationController?.pushViewController(EventDetailViewController(event: events[indexPath.section]),
                                                          animated: true)
        }
    }
}
