//
//  ContactDetailViewController.swift
//  icaew
//
//  Created by Mohammad Nuruddin Effendi on 7/11/16.
//  Copyright © 2016 Jiggie. All rights reserved.
//

import UIKit

private let kContactCellIdentifier = "kContactCellIdentifier"
private let kTableHeaderViewHeight: CGFloat = 213

class ContactDetailViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    private var headerImageView = UIImageView(image: UIImage(named: "image-home")!)
    private var items = [[String : String]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationBar(title: "ICAEW OFFICE INDONESIA")
        self.setupView()
        self.loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Data
    private func loadData() {
        self.showHUD()
        Contact.retrieveContactDetail(id: 1) { (result) in
            switch result {
            case .Success(let contact):
                self.items.append(["address-icon" : "ICAEW "+contact.countryName+"*#*"+contact.address])
                self.items.append(["phone-icon" : contact.phoneNumber])
                self.items.append(["email-icon" : contact.emailAddress])
                self.items.append(["facebook-icon" : contact.facebookAddress])
                self.items.append(["website-icon" : contact.websiteAddress])
                self.tableView.reloadData()
                
            case .Error(_):
                break
            }
            
            self.dismissHUD()
        }
    }
    
    // MARK: View
    private func setupView() {
        self.headerImageView.frame = CGRectMake(0, 0, UIScreen.width(), kTableHeaderViewHeight)
        self.headerImageView.contentMode = .ScaleAspectFill
        self.headerImageView.clipsToBounds = true
        
        let headerView = UIView(frame: CGRectMake(0, 0, UIScreen.width(), kTableHeaderViewHeight))
        headerView.addSubview(headerImageView)
        
        self.tableView.tableHeaderView = headerView
        self.tableView.tableFooterView = UIView()
    }
    
    // MARK: UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(kContactCellIdentifier) as UITableViewCell!
        
        if cell == nil {
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: kContactCellIdentifier)
        }
        
        let item = self.items[indexPath.row]
        
        cell.selectionStyle = .None
        cell.backgroundColor = UIColor.clearColor()
        cell.imageView?.image = UIImage(named: item.keys.first!)
        
        if indexPath.row == 0 {
            let text = item.values.first!.componentsSeparatedByString("*#*")
            cell.textLabel?.text = text[0]
            cell.detailTextLabel?.text = text[1]
            cell.detailTextLabel?.textColor = UIColor.lightGrayColor()
        } else {
            cell.textLabel?.text = item.values.first!
            cell.detailTextLabel?.text = nil
        }
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            let item = self.items[indexPath.row]
            let text = item.values.first!.componentsSeparatedByString("*#*")
            
            return 30 + text[1].getTextHeight(CGRectGetWidth(tableView.bounds) - 135,
                                              font: UIFont.systemFontOfSize(15))
        }
        
        return 40
    }
    
    // MARK: UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let yPos = -scrollView.contentOffset.y
        
        if yPos > 0 {
            var imageViewFrame = self.headerImageView.frame
            imageViewFrame.origin.y = scrollView.contentOffset.y
            imageViewFrame.size.height = kTableHeaderViewHeight+yPos
            self.headerImageView.frame = imageViewFrame
        }
    }
}
