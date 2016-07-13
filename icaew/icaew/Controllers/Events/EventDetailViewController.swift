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
        
        var subtitle = event.subtitle
        subtitle += "<style>body{font-family: '\(self.subtitleLabel.font.fontName)'; font-size: \(self.subtitleLabel.font.pointSize)px; color: #787878;}</style>"
        
        if let htmlData = subtitle.dataUsingEncoding(NSUnicodeStringEncoding) {
            do {
                let attributedText = try NSAttributedString(data: htmlData, options: [NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute : NSUTF8StringEncoding], documentAttributes: nil)
                self.subtitleLabel.text = nil
                self.subtitleLabel.attributedText = attributedText
            } catch let error {
                print("Couldn't translate \(description): \(error) ")
            }
        } else {
            self.subtitleLabel.attributedText = nil
            self.subtitleLabel.text = self.event.subtitle
        }
        
        var detail = event.detail
        detail += "<style>body{font-family: '\(self.detailLabel.font.fontName)'; font-size: \(self.detailLabel.font.pointSize)px; color: #000000;}</style>"
        
        if let htmlData = detail.dataUsingEncoding(NSUnicodeStringEncoding) {
            do {
                let attributedText = try NSAttributedString(data: htmlData, options: [NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute : NSUTF8StringEncoding], documentAttributes: nil)
                self.detailLabel.text = nil
                self.detailLabel.attributedText = attributedText
            } catch let error {
                print("Couldn't translate \(description): \(error) ")
            }
        } else {
            self.detailLabel.attributedText = nil
            self.detailLabel.text = self.event.detail
        }
    }
}
