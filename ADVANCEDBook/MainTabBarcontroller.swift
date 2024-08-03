//
//  MainTabBarcontroller.swift
//  ADVANCEDBook
//
//  Created by 이진규 on 8/4/24.
//

import UIKit

class MainTabBarcontroller: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let firstVC = ViewController()
        firstVC.tabBarItem = UITabBarItem(title: "첫번쨰", image: .init(systemName: "magnifyingglass"), tag: 0)


        let secondVC = ViewController2()
        secondVC.tabBarItem = UITabBarItem(title: "두번쨰", image: .init(systemName: "book"), tag: 0)

        viewControllers = [firstVC,secondVC]
    }
}
