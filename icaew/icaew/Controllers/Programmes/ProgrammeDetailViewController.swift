//
//  ProgrammeDetailViewController.swift
//  icaew
//
//  Created by Mohammad Nuruddin Effendi on 7/11/16.
//  Copyright © 2016 Jiggie. All rights reserved.
//

import UIKit
import MessageUI
import youtube_ios_player_helper

class ProgrammeDetailViewController: BaseViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var playerView: YTPlayerView!
    
    private var programme: Programme!
    
    
    convenience init(programme: Programme) {
        self.init(nibName: "ProgrammeDetailViewController", bundle: nil)
        self.programme = programme
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let videoId = self.programme.youtubeURL.componentsSeparatedByString("watch?v=").last!
        
        self.detailLabel.text = self.programme.detail
        self.playerView.loadWithVideoId(videoId)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupNavigationBar(title: programme.title.uppercaseString)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Action
    @IBAction func didTapShareButton(sender: AnyObject) {
        let activityViewController = UIActivityViewController(activityItems: [self.detailLabel.attributedText!, NSURL(string: programme.youtubeURL)!], applicationActivities: nil)
        
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func didTapLikeButton(sender: AnyObject) {
    }
    
    @IBAction func didTapInquiryButton(sender: AnyObject) {
        let mailComposeViewController = MFMailComposeViewController()
        mailComposeViewController.mailComposeDelegate = self
        
        self.presentViewController(mailComposeViewController, animated: true, completion: nil)
    }

    @IBAction func didTapInfoButton(sender: AnyObject) {
        let mailComposeViewController = MFMailComposeViewController()
        mailComposeViewController.mailComposeDelegate = self
        
        self.presentViewController(mailComposeViewController, animated: true, completion: nil)
    }
    
    // MARK: MFMailComposeViewControllerDelegate
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
