//
//  AppDelegate.swift
//  Swift_Benkey
//
//  Created by 申民鐡 on 2022/07/13.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    
    //LoginViewController를 생성한다
    let loginViewController = LoginViewController()
    let onboardingContainerViewController = OnboardingContainerViewController()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        //loginviewcontroller를 delegate인걸 알려준다.
        loginViewController.delegate = self
        
        onboardingContainerViewController.delegate = self
        //루트뷰를 적용해준다.
        window?.rootViewController = onboardingContainerViewController
        
        return true
    }
}
//appdelegate에서 적용가능하게 delegate를 선언해준다.
extension AppDelegate:LoginViewControllerDelegate, OnboardingContainerViewControllerDelegate {
    func didFinishiOnboarding() {
        print("foo - Did Onobarding")
    }
    
    func didLogin() {
        print("foo - did Login")
    }
//
//    @objc func nextTapped(_ sender: UIButton) {
//        guard let nextVC = getNextViewController(from: currentVC) else { return }
//        pageViewController.setViewControllers([nextVC], direction: .forward, animated: true, completion: nil)
//    }
//
//    @objc func backTapped(_ sender: UIButton) {
//        guard let previousVC = getPreviousViewController(from: currentVC) else { return }
//        pageViewController.setViewControllers([previousVC], direction: .reverse, animated: true, completion: nil)
//    }
//
//    @objc func closeTapped(_ sender: UIButton) {
//        delegate?.didFinishOnboarding()
//    }
//
//    @objc func doneTapped(_ sender: UIButton) {
//        delegate?.didFinishOnboarding()
//    }
//
//
}
