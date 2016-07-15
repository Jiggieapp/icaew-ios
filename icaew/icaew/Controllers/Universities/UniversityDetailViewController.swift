//
//  UniversityDetailViewController.swift
//  icaew
//
//  Created by Setiady Wiguna on 7/12/16.
//  Copyright © 2016 Jiggie. All rights reserved.
//

import UIKit

class UniversityDetailViewController: BaseViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var contentViewHeightConstraint: NSLayoutConstraint!
    
    private var country: Country!
    private var universities: [University]?
    
    convenience init(country: Country) {
        self.init(nibName: "UniversityDetailViewController", bundle: nil)
        self.country = country
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupView()
        self.loadData()
    }

    func setupView() {
        self.setupNavigationBar(title: self.country.name.uppercaseString)
    }
    
    // MARK: Data
    private func loadData() {
        self.showHUD()
        University.retrieveUniversityDetail(self.country.id, completionHandler: {(result) in
            switch result {
            case .Success(let universities):
                self.universities = universities
                
                if self.universities?.count > 0 {
                    let university = self.universities![0]
                    self.descriptionLabel.text = university.descriptionInfo
                    self.addressLabel.text = "Address: " + university.address
                    self.phoneLabel.text = "Phone: " + university.phoneNumber
                    self.emailLabel.text = "Email: " + university.emailAddress

                    let triggerTime = (Int64(1) * 10)
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
                        self.updateScrollHeight()
                    })
                }
                
            case .Error(_):
                break
            }
            
            self.dismissHUD()
        })
    }
    
    private func updateScrollHeight() {
        self.contentViewHeightConstraint.constant = CGRectGetMaxY(self.emailLabel.frame) + 20
        print(CGRectGetMaxY(self.emailLabel.frame) + 20)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
