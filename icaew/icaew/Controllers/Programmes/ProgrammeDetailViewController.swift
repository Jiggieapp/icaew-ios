//
//  ProgrammeDetailViewController.swift
//  icaew
//
//  Created by Mohammad Nuruddin Effendi on 7/11/16.
//  Copyright © 2016 Jiggie. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class ProgrammeDetailViewController: BaseViewController {

    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var playerView: YTPlayerView!
    
    private var programme: Programme!
    
    
    convenience init(programme: Programme) {
        self.init(nibName: "ProgrammeDetailViewController", bundle: nil)
        self.programme = programme
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupNavigationBar(title: programme.title.uppercaseString)
        
        var detail = self.programme.detail
        detail += "<style>body{font-family: '\(self.detailLabel.font.fontName)'; font-size: \(self.detailLabel.font.pointSize)px; color: #000000;}</style>"
        
        if let htmlData = description.dataUsingEncoding(NSUnicodeStringEncoding) {
            do {
                let attributedText = try NSAttributedString(data: htmlData, options: [NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute : NSUTF8StringEncoding], documentAttributes: nil)
                self.detailLabel.attributedText = attributedText
            } catch let error {
                print("Couldn't translate \(description): \(error) ")
            }
        } else {
            self.detailLabel.text = self.programme.detail
        }
        
        let videoId = self.programme.youtubeURL.componentsSeparatedByString("watch?v=").last!
        self.playerView.loadWithVideoId(videoId)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
