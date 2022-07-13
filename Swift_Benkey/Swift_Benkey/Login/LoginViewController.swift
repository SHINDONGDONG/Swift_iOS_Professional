//
//  ViewController.swift
//  Swift_Benkey
//
//  Created by 申民鐡 on 2022/07/13.
//

import UIKit

class LoginViewController: UIViewController {

    //MARK: - Properties
    //만들었던 기본적인 loginview를 인스턴스화 시킨다.
    let loginView = LoginView()
    
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }

    //MARK: - Configures

}

extension LoginViewController {
    private func style() {
        //로그인뷰를 자유자재로 움직일 수 있도록 false해줌.
        loginView.translatesAutoresizingMaskIntoConstraints = false
    }
    private func layout() {
        view.addSubview(loginView)
        
        //layout 을 active시켜준다.
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1)
        ])
    }
    
}

