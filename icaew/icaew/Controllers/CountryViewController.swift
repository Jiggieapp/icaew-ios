//
//  CountryViewController.swift
//  icaew
//
//  Created by Setiady Wiguna on 7/11/16.
//  Copyright © 2016 Jiggie. All rights reserved.
//

import UIKit

enum CountrySource: Int {
    case contact = 0
    case event = 1
    case university = 2
}

class CountryViewController: UIViewController {
    
    var countrySource: CountrySource
    
    override func initWithSource(countrySource: CountrySource) {
        self.initNIB 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupView()
    }
    
    func setupView() {
        switch countrySource {
        case .contact:
            
        default:
            <#code#>
        }
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
