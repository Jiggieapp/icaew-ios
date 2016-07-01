//
//  ProgrammesViewController.swift
//  icaew
//
//  Created by Setiady Wiguna on 6/29/16.
//  Copyright © 2016 Jiggie. All rights reserved.
//

import UIKit

private let kProgrammesCellIdentifier = "kProgrammesCellIdentifier"
private let kTableHeaderViewHeight: CGFloat = 213

class ProgrammesViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    private var headerImageView: UIImageView?
    private var headerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideNavigationBar()
        self.setupView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: View
    private func setupView() {
        self.headerView = UIView(frame: CGRectMake(0, 0, UIScreen.width(), kTableHeaderViewHeight))
        self.headerImageView = UIImageView(image: UIImage(named: "image-home")!)
        
        if let headerImageView = self.headerImageView {
            self.headerView.addSubview(headerImageView)
            
            headerImageView.contentMode = .ScaleAspectFill
            headerImageView.clipsToBounds = true
            self.headerView.clipsToBounds = true
        }
        
        self.tableView.tableHeaderView = self.headerView
        self.tableView.tableFooterView = UIView()
        self.tableView.registerNib(ProgrammesTableViewCell.nib(),
                                   forCellReuseIdentifier: kProgrammesCellIdentifier)
    }
    
    // MARK: UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kProgrammesCellIdentifier) as! ProgrammesTableViewCell
        
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
    
    // MARK: UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if self.headerView.clipsToBounds {
            self.headerView.clipsToBounds = false
        }
        
        if let headerImageView = self.headerImageView {
            let yPos = -scrollView.contentOffset.y
            
            if yPos > 0 {
                var imageViewFrame = headerImageView.frame
                imageViewFrame.origin.y = scrollView.contentOffset.y
                imageViewFrame.size.height = kTableHeaderViewHeight+yPos
                headerImageView.frame = imageViewFrame
            }
        }
    }

}
