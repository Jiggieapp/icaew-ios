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
    private var country: Country!
    
    convenience init(country: Country) {
        self.init(nibName: "ContactDetailViewController", bundle: nil)
        self.country = country
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationBar(title: "ICAEW OFFICE "+country.name.uppercaseString)
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
        Contact.retrieveContactDetail(countryId: country.id) { (result) in
            switch result {
            case .Success(let contacts):
                for contact in contacts {
                    self.items.append(["address-icon" : "ICAEW "+contact.countryName+"*#*"+contact.address])
                    self.items.append(["phone-icon" : contact.phoneNumber])
                    self.items.append(["email-icon" : contact.emailAddress])
                    
                    if contact.facebookAddress.characters.count > 0 {
                        self.items.append(["facebook-icon" : contact.facebookAddress])
                    }
                    if contact.websiteAddress.characters.count > 0 {
                        self.items.append(["website-icon" : contact.websiteAddress])
                    }
                }
                
                if let contact = contacts.first {
                    self.headerImageView.sd_setImageWithURL(NSURL(string: contact.imageURL),
                                                            placeholderImage: UIImage(named: "image-home")!)
                }
                
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
        cell.textLabel?.font = UIFont.systemFontOfSize(15)
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        
        if item.keys.first! == "address-icon" {
            let text = item.values.first!.componentsSeparatedByString("*#*")
            cell.textLabel?.text = text[0]
            cell.detailTextLabel?.numberOfLines = 0
            cell.detailTextLabel?.font = UIFont.systemFontOfSize(15)
            cell.detailTextLabel?.text = text[1]
            cell.detailTextLabel?.textColor = UIColor.lightGrayColor()
            
            if indexPath.row != 0 {
                let width = UIScreen.width() / 3
                let separatorView = UIView(frame: CGRectMake((UIScreen.width() / 2 - width / 2), 8, width, 0.5))
                separatorView.backgroundColor = UIColor.lightGrayColor()
                cell.addSubview(separatorView)
            }
        } else {
            cell.textLabel?.text = item.values.first!
            cell.detailTextLabel?.text = nil
        }
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let item = self.items[indexPath.row]
        
        if item.keys.first! == "address-icon" {
            let item = self.items[indexPath.row]
            let text = item.values.first!.componentsSeparatedByString("*#*")
            
            if indexPath.row != 0 {
                return 50 + text[1].getTextHeight(CGRectGetWidth(tableView.bounds) - 90,
                                                  font: UIFont.systemFontOfSize(15))
            }
            
            return 30 + text[1].getTextHeight(CGRectGetWidth(tableView.bounds) - 90,
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
