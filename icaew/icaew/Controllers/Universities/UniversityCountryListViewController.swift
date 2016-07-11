//
//  UniversityCountryListViewController.swift
//  icaew
//
//  Created by Setiady Wiguna on 6/29/16.
//  Copyright © 2016 Jiggie. All rights reserved.
//

import UIKit

class UniversityCountryListViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupView()
    }

    func setupView() {
        self.setupNavigationBar(title: "ICAEW PARTNER UNIVERSITY")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
