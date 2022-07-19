//
//  TabBarViewController.swift
//  Swift_Benkey
//
//  Created by 申民鐡 on 2022/07/19.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = UINavigationController(rootViewController: SearchView())
        let vc2 = UINavigationController(rootViewController: ContackView())
        let vc3 = UINavigationController(rootViewController: FavoView())

        vc1.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        vc2.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        vc3.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
        
        setViewControllers([vc1,vc2,vc3], animated: true)
    }
}


class SearchView:UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        view.backgroundColor = .systemBackground
        
    }
}

class ContackView:UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Conta"
        view.backgroundColor = .systemBackground
        
    }
}

class FavoView:UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorite"
        view.backgroundColor = .systemBackground
        
    }
}
