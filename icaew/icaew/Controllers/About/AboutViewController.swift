//
//  AboutViewController.swift
//  icaew
//
//  Created by Setiady Wiguna on 6/29/16.
//  Copyright © 2016 Jiggie. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import Mantle

private let kTableHeaderViewHeight: CGFloat = 213

class AboutViewController: BaseViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var headerImageView = UIImageView(image: UIImage(named: "image-home")!)
    private var aboutDict: [String : AnyObject]?
    private let kAboutDynamicTextCellIdentifier = "DynamicTextCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
        self.loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupView() {
        self.headerImageView.frame = CGRectMake(0, 0, UIScreen.width(), kTableHeaderViewHeight)
        self.headerImageView.contentMode = .ScaleAspectFill
        self.headerImageView.clipsToBounds = true
        
        let headerView = UIView(frame: CGRectMake(0, 0, UIScreen.width(), kTableHeaderViewHeight))
        headerView.addSubview(headerImageView)
        
        self.tableView.tableHeaderView = headerView
        self.tableView.tableFooterView = UIView()
        self.tableView.registerNib(DynamicTextCell.nib(),
                                   forCellReuseIdentifier: kAboutDynamicTextCellIdentifier)
        self.tableView.estimatedRowHeight = 80;
        self.tableView.setNeedsLayout()
        self.tableView.layoutIfNeeded()
    }
    
    // MARK: - Data
    private func loadData() {
        self.showHUD()
        if let request = NetworkManager.request(.GET, "about") {
            request.responseJSON(completionHandler: { (response) in
                switch response.result {
                case .Success(let jsonResult):
                    if let jsonDict = jsonResult as? [String : AnyObject] {
                        if let data = jsonDict["data"] as? [String : AnyObject] {
                            self.aboutDict = data
                            
                            if let aboutDict = self.aboutDict {
                                if let image = aboutDict["image"] as? String {
                                    self.headerImageView.sd_setImageWithURL(NSURL(string: image),
                                        placeholderImage: UIImage(named: "image-home")!)
                                }
                                
                                if let title = aboutDict["title"] as? String {
                                    self.setupNavigationBar(title: title.uppercaseString)
                                }
                            }
                            self.tableView.reloadData()
                        }
                    }
                    
                case .Failure(let error):
                    print(error)
                }
                
                self.dismissHUD()
            })
        }
    }
    
    // MARK: -  UITableviewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let _ = self.aboutDict else {
            return 0
        }
        
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kAboutDynamicTextCellIdentifier) as! DynamicTextCell
        
        if let aboutDict = self.aboutDict {
            if var description = aboutDict["description"] as? String {
                
                description += "<style>body{font-family: '\(cell.dynamicTextLabel.font.fontName)'; font-size: \(cell.dynamicTextLabel.font.pointSize)px; color: #000000;}</style>"
                
                if let htmlData = description.dataUsingEncoding(NSUnicodeStringEncoding) {
                    do {
                        let attributedText = try NSAttributedString(data: htmlData, options: [NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute : NSUTF8StringEncoding], documentAttributes: nil)
                        cell.dynamicTextLabel.text = nil
                        cell.dynamicTextLabel.attributedText = attributedText
                    } catch let error {
                        print("Couldn't translate \(description): \(error) ")
                    }
                } else {
                    cell.dynamicTextLabel.attributedText = nil
                    cell.dynamicTextLabel.text = description
                }
            }
        }
        
        return cell
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
