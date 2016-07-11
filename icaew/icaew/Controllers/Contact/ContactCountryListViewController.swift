//
//  ContactCountryListViewController.swift
//  icaew
//
//  Created by Setiady Wiguna on 6/29/16.
//  Copyright © 2016 Jiggie. All rights reserved.
//

import UIKit

class ContactCountryListViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationBar(title: "ICAEW OFFICES IN SOUTH EAST ASIA")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.removeBackButtonTitle()
        self.navigationController?.pushViewController(ContactDetailViewController(), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
