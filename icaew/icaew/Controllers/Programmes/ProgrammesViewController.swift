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
    
    private var headerImageView = UIImageView(image: UIImage(named: "image-home")!)
    private var headerView: UIView!
    private var programmes: [Programme]?
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        self.loadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.hideNavigationBar(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Data
    private func loadData() {
        self.showHUD()
        Programme.retrieveProgrammes { (result) in
            switch result {
            case .Success(let programmes):
                self.programmes = programmes
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
        
        self.headerView = UIView(frame: CGRectMake(0, 0, UIScreen.width(), kTableHeaderViewHeight))
        self.headerView.addSubview(headerImageView)

        self.tableView.tableHeaderView = self.headerView
        self.tableView.tableFooterView = UIView()
        self.tableView.registerNib(ProgrammesTableViewCell.nib(),
                                   forCellReuseIdentifier: kProgrammesCellIdentifier)
    }
    
    // MARK: UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        guard let programmes = self.programmes else {
            return 0
        }
        
        return programmes.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kProgrammesCellIdentifier) as! ProgrammesTableViewCell
        cell.selectionStyle = .None
        
        if let programmes = self.programmes {
            let programme = programmes[indexPath.section]
            cell.initialLabel.text = programme.initial.uppercaseString
            cell.titleLabel.text = programme.title.capitalizedString
            
            var detail = programme.detail
            detail += "<style>body{font-family: '\(cell.detailLabel.font.fontName)'; font-size: \(cell.detailLabel.font.pointSize)px; color: #AAAAAA;}</style>"
            
            if let htmlData = description.dataUsingEncoding(NSUnicodeStringEncoding) {
                do {
                    let attributedText = try NSAttributedString(data: htmlData, options: [NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute : NSUTF8StringEncoding], documentAttributes: nil)
                    cell.detailLabel.text = nil
                    cell.detailLabel.attributedText = attributedText
                } catch let error {
                    print("Couldn't translate \(description): \(error) ")
                }
            } else {
                cell.detailLabel.attributedText = nil
                cell.detailLabel.text = programme.detail
            }
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
        
        if let programmes = self.programmes {
            let programme = programmes[indexPath.section]
            
            self.removeBackButtonTitle()
            self.navigationController?.pushViewController(ProgrammeDetailViewController(programme: programme), animated: true)
        }
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
