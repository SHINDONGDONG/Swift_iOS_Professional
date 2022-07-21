//
//  AppDelegate.swift
//  Swift_Benkey
//
//  Created by 申民鐡 on 2022/07/13.
//

import UIKit

let appColor: UIColor = .systemTeal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    //LoginViewController를 생성한다
    let loginViewController = LoginViewController()
    let onboardingContainerViewController = OnboardingContainerViewController()
//    let dummyViewController = DummyViewController()
    let mainViewController = MainViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        //loginviewcontroller를 delegate인걸 알려준다.
        loginViewController.delegate = self
        onboardingContainerViewController.delegate = self
        //        dummyViewController.logoutDelegate = self
        
        
        registerForNotifications()
        
        displayLogin()
        return true
    }
    
    private func registerForNotifications() {
        //notification은 자기자신을 감시할것이다. 감시할때 selector가 실행되면
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didLogout),
            name: .logout,
            object: nil)
    }
    
    
    private func displayLogin() {
        setRootViewController(loginViewController)
    }
    private func displayNextScreen() {
        //UserDefaults에서 hasonboard가 true일경우 mainviewcontroller로 이동한다.
        if LocalState.hasOnboared {
            prepMainView()
            setRootViewController(mainViewController)
        }else {
            //한번도 onboarding을 가지않았을경우 onboarding으로 이동
            setRootViewController(onboardingContainerViewController)
        }
    }
    private func prepMainView(){
        mainViewController.setStatusBar()
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backgroundColor = appColor
        UIScrollView.appearance().bounces = false
    }
    
}


extension AppDelegate:LoginViewControllerDelegate, OnboardingContainerViewControllerDelegate, logoutDelegate {
    @objc func didLogout() {
        setRootViewController(loginViewController)
    }
    func didFinishiOnboarding() {
        //onboard를 끝내고 dummy로 갈때 hasOnboard를 true로 변경
        LocalState.hasOnboared = true
        prepMainView()
        setRootViewController(mainViewController)
    }
    func didLogin() {
        //로그인화면에서 onboard 상태를 확인하고 화면전환을시킨다
        displayNextScreen()
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

