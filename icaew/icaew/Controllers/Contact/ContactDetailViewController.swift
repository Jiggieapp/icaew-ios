//
//  ContactDetailViewController.swift
//  icaew
//
//  Created by Mohammad Nuruddin Effendi on 7/11/16.
//  Copyright © 2016 Jiggie. All rights reserved.
//

import UIKit

private let kTableHeaderViewHeight: CGFloat = 213

class ContactDetailViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    private var headerImageView = UIImageView(image: UIImage(named: "image-home")!)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationBar(title: "")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    // MARK: UITableViewDelegate
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return
//    }
    
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
