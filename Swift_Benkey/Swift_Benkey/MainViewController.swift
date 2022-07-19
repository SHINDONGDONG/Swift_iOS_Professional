//
//  MainViewController.swift
//  Swift_Benkey
//
//  Created by 申民鐡 on 2022/07/19.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTabBar()
    }

    private func setupViews() {
        //3개의 VC를 담아준다.
        let summaryVC = AccountSummaryViewController()
        let moneyVC = MoveMoneyViewController()
        let moreVC = MoreViewController()
        
        //각각 이미지와 타이틀을 설정해준다.
        summaryVC.setTabBarImage(imageName: "list.dash.header.rectangle", title: "Summary")
        moneyVC.setTabBarImage(imageName: "arrow.left.arrow.right", title: "Move Money")
        moreVC.setTabBarImage(imageName: "ellipsis.circle", title: "More")
        
        //각각 UINaviationController에 담아준다.
        let summaryNC = UINavigationController(rootViewController: summaryVC)
        let moneyNC = UINavigationController(rootViewController: moneyVC)
        let moreNC = UINavigationController(rootViewController: moreVC)
        
        //Navigation bartintColor를 appColor로 바꿔준다.
        summaryNC.navigationBar.barTintColor = appColor
        
        //summaryNC의 navigationBar를 숨긴다.
        hideNavigationBarLine(summaryNC.navigationBar)
        
        //NC를 배열로 담아준다.
        let tabBarList = [summaryNC,moneyNC,moreNC]
        
        //viewControllers에 배열을 뿌려준다.
        viewControllers = tabBarList
        
    }

    private func hideNavigationBarLine(_ navigationBar: UINavigationBar) {
        
        let img = UIImage()
        navigationBar.shadowImage = img
        navigationBar.setBackgroundImage(img, for: .default)
        navigationBar.isTranslucent = false
        
    }

    private func setupTabBar() {
        tabBar.tintColor = appColor
        //tabbar를 일체형일지 아닐지 (false면 나눠준다.)
        tabBar.isTranslucent = false
    }
}

//각각의 ViewControllers
class AccountSummaryViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .systemGreen
    }
}

class MoveMoneyViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .systemOrange
    }
}

class MoreViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .systemPurple
    }
}
