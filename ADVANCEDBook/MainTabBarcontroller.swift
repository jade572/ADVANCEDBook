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

        let firstVC = MainViewController()
        firstVC.tabBarItem = UITabBarItem(title: "검색" , image: .init(systemName: "magnifyingglass"), tag: 0)


        let secondVC = addBookViewController()
        secondVC.tabBarItem = UITabBarItem(title: "담은 책", image: .init(systemName: "book"), tag: 0)

        viewControllers = [firstVC,secondVC]
    }
}
