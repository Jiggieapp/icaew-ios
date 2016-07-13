//
//  UniversityDetailViewController.swift
//  icaew
//
//  Created by Setiady Wiguna on 7/12/16.
//  Copyright © 2016 Jiggie. All rights reserved.
//

import UIKit

class UniversityDetailViewController: BaseViewController {

    private var country: Country!
    private var university: University?
    
    convenience init(country: Country) {
        self.init(nibName: "UniversityDetailViewController", bundle: nil)
        self.country = country
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupView()
    }

    func setupView() {
        self.setupNavigationBar(title: self.country.name.uppercaseString)
    }
    
    // MARK: Data
    private func loadData() {
        self.showHUD()
        University.retrieveUniversityDetail(self.country.id, completionHandler: {(result) in
            switch result {
            case .Success(let university):
                self.university = university
                
            case .Error(_):
                break
            }
            
            self.dismissHUD()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
