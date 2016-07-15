//
//  EventDetailViewController.swift
//  icaew
//
//  Created by Mohammad Nuruddin Effendi on 7/13/16.
//  Copyright © 2016 Jiggie. All rights reserved.
//

import UIKit

class EventDetailViewController: BaseViewController {

    @IBOutlet var contentView: UIView!
    @IBOutlet var roundedView: UIView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    
    private(set) var event: Event!
    
    
    convenience init(event: Event) {
        self.init(nibName: "EventDetailViewController", bundle: nil)
        self.event = event
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationBar(title: self.event.title.uppercaseString)
        
        self.setupView()
        self.setupData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.roundedView.layer.cornerRadius = CGRectGetHeight(self.roundedView.bounds) / 2
        self.roundedView.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: View
    private func setupView() {
        self.contentView.layer.borderColor = UIColor(hexString: "DEDEDE")?.CGColor
        self.contentView.layer.borderWidth = 1
    }
    
    // MARK: Data
    private func setupData() {
        let date = NSDate.dateFromString("yyyy-MM-dd HH:mm:ss", string: self.event.startDate)
        
        if let date = date,
            stringDate = NSDate.stringFromDate(date, format: "MMM dd") {
            let startDate = stringDate.stringByReplacingOccurrencesOfString(" ", withString: "\n")
            self.dateLabel.text = startDate
        }
        
        self.titleLabel.text = self.event.title
        self.subtitleLabel.text = self.event.subtitle
        self.detailLabel.text = self.event.detail
    }
}
