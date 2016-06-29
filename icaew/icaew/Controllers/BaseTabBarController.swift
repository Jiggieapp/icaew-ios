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
        let eventsNavigationController = UINavigationController(rootViewController: EventCountryListViewController())
        let universityNavigationController = UINavigationController(rootViewController: UniversityCountryListViewController())
        let contactNavigationController = UINavigationController(rootViewController: ContactCountryListViewController())
        let aboutNavigationController = UINavigationController(rootViewController: AboutViewController())
        
        let tabBarController = BaseTabBarController()
        tabBarController.tabBar.translucent = false
        tabBarController.viewControllers = [programmesNavigationController,
                                            eventsNavigationController,
                                            universityNavigationController,
                                            contactNavigationController,
                                            aboutNavigationController]
        
        let titleTextAttributes = [NSFontAttributeName : UIFont.systemFontOfSize(10)];
        let titlePosition = UIOffsetMake(0, -3)
        
        var tabBarItems = tabBarController.tabBar.items as [UITabBarItem]!
        tabBarItems[0].image = UIImage(named: "tab-events-icon")
        tabBarItems[0].imageInsets = UIEdgeInsetsMake(0, -0.5, 0, 0.5)
        tabBarItems[0].title = "Programmes"
        tabBarItems[0].titlePositionAdjustment = titlePosition
        tabBarItems[0].setTitleTextAttributes(titleTextAttributes, forState: .Normal)
        
        tabBarItems[1].image = UIImage(named: "tab-social-icon")
        tabBarItems[1].imageInsets = UIEdgeInsetsMake(0, -2, 0, 2)
        tabBarItems[1].title = "Events"
        tabBarItems[1].titlePositionAdjustment = titlePosition
        tabBarItems[1].setTitleTextAttributes(titleTextAttributes, forState: .Normal)
        
        tabBarItems[2].image = UIImage(named: "tab-chat-icon")
        tabBarItems[2].title = "Universities"
        tabBarItems[2].titlePositionAdjustment = titlePosition
        tabBarItems[2].setTitleTextAttributes(titleTextAttributes, forState: .Normal)
        
        tabBarItems[3].image = UIImage(named: "tab-more-icon")
        tabBarItems[3].title = "About Us"
        tabBarItems[3].titlePositionAdjustment = titlePosition
        tabBarItems[3].setTitleTextAttributes(titleTextAttributes, forState: .Normal)
        
        tabBarItems[4].image = UIImage(named: "tab-more-icon")
        tabBarItems[4].title = "Contact Us"
        tabBarItems[4].titlePositionAdjustment = titlePosition
        tabBarItems[4].setTitleTextAttributes(titleTextAttributes, forState: .Normal)
        
        tabBarController.selectedIndex = selected!
        
        return tabBarController
    }
    
}
