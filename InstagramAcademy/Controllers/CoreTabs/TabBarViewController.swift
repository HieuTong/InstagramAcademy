//
//  TabBarViewController.swift
//  InstagramAcademy
//
//  Created by HieuTong on 5/1/21.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let vc1 = HomeViewController()
        let vc2 = ExploreViewController()
        let vc3 = CameraViewController()
        let vc4 = NotificationViewController()
        let vc5 = ProfileViewController()
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        let nav4 = UINavigationController(rootViewController: vc4)
        let nav5 = UINavigationController(rootViewController: vc5)
        
        nav1.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "house"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "globe"), tag: 1)
        nav3.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "plus"), tag: 1)
        nav4.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "bell"), tag: 1)
        nav5.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "person"), tag: 1)
        
        setViewControllers([nav1, nav2, nav3, nav4, nav5], animated: false)
    }


}
