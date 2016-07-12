//
//  BaseTabBarController.swift
//  
//
//  Created by uudshan on 24/03/16.
//  Copyright © 2016 Mohammad Nuruddin Effendi. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
    }
    
    static func defaultTabBarController(selected: Int? = 0) -> BaseTabBarController {
        let programmesNavigationController = UINavigationController(rootViewController: ProgrammesViewController())
        let eventsNavigationController = UINavigationController(rootViewController: CountryViewController( countrySource: CountrySource.event))
        let universityNavigationController = UINavigationController(rootViewController: CountryViewController(countrySource: CountrySource.university))
        let aboutNavigationController = UINavigationController(rootViewController: AboutViewController())
        let contactNavigationController = UINavigationController(rootViewController: CountryViewController(countrySource: CountrySource.contact))
        
        let tabBarController = BaseTabBarController()
        tabBarController.tabBar.translucent = false
        tabBarController.tabBar.tintColor = UIColor.whiteColor()
        tabBarController.tabBar.barTintColor = UIColor.blackColor()
        tabBarController.viewControllers = [programmesNavigationController,
                                            eventsNavigationController,
                                            universityNavigationController,
                                            aboutNavigationController,
                                            contactNavigationController]
        
        let titleTextAttributes = [NSFontAttributeName : UIFont.systemFontOfSize(9)];
        let titlePosition = UIOffsetMake(0, -3)
        
        var tabBarItems = tabBarController.tabBar.items as [UITabBarItem]!
        tabBarItems[0].image = UIImage(named: "tabicon-programmes")
        tabBarItems[0].imageInsets = UIEdgeInsetsMake(0, -0.5, 0, 0.5)
        tabBarItems[0].title = "Programmes"
        tabBarItems[0].titlePositionAdjustment = titlePosition
        tabBarItems[0].setTitleTextAttributes(titleTextAttributes, forState: .Normal)
        
        tabBarItems[1].image = UIImage(named: "tabicon-event")
        tabBarItems[1].imageInsets = UIEdgeInsetsMake(0, -2, 0, 2)
        tabBarItems[1].title = "Events"
        tabBarItems[1].titlePositionAdjustment = titlePosition
        tabBarItems[1].setTitleTextAttributes(titleTextAttributes, forState: .Normal)
        
        tabBarItems[2].image = UIImage(named: "tabicon-universities")
        tabBarItems[2].title = "Universities"
        tabBarItems[2].titlePositionAdjustment = titlePosition
        tabBarItems[2].setTitleTextAttributes(titleTextAttributes, forState: .Normal)
        
        tabBarItems[3].image = UIImage(named: "tabicon-about-us")
        tabBarItems[3].title = "About Us"
        tabBarItems[3].titlePositionAdjustment = titlePosition
        tabBarItems[3].setTitleTextAttributes(titleTextAttributes, forState: .Normal)
        
        tabBarItems[4].image = UIImage(named: "tabicon-contact-us")
        tabBarItems[4].title = "Contact Us"
        tabBarItems[4].titlePositionAdjustment = titlePosition
        tabBarItems[4].setTitleTextAttributes(titleTextAttributes, forState: .Normal)
        
        tabBarController.selectedIndex = selected!
        
        return tabBarController
    }
    
}
