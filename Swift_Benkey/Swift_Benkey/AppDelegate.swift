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
    let dummyViewController = DummyViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        //loginviewcontroller를 delegate인걸 알려준다.
        loginViewController.delegate = self
        
        onboardingContainerViewController.delegate = self
        
        dummyViewController.logoutDelegate = self
        //루트뷰를 적용해준다.
        window?.rootViewController = loginViewController
        
        return true
    }
}
//appdelegate에서 적용가능하게 delegate를 선언해준다.
extension AppDelegate:LoginViewControllerDelegate, OnboardingContainerViewControllerDelegate, logoutDelegate {
    func didLogout() {
        setRootViewController(loginViewController)
    }
    func didFinishiOnboarding() {
        setRootViewController(dummyViewController)
    }
    func didLogin() {
        setRootViewController(onboardingContainerViewController)
    }
    
    
}

extension AppDelegate {
    
    func setRootViewController(_ vc:UIViewController, animated: Bool = true) {
        guard animated, let widown = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        widown.rootViewController = vc
        widown.makeKeyAndVisible()
        UIView.transition(with: widown, duration: 0.7, options: .transitionCrossDissolve, animations: nil,completion: nil )
    }
}

