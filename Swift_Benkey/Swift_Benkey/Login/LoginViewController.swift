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
    
    let signButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign In", for: [])
        button.configuration = .filled()
        button.configuration?.imagePadding = 8
        button.addTarget(self, action: #selector(signinTapped), for: .primaryActionTriggered)
        return button
    }()
    
    let errorMessage: UILabel = {
        let error = UILabel()
        error.text = nil
        error.isHidden = true
        error.textAlignment = .center
        error.translatesAutoresizingMaskIntoConstraints  = false
        error.textColor = .systemRed
        error.numberOfLines = 0
        return error
    }()
    
    var username: String? {
        return loginView.usernameTextField.text
    }
    
    var password: String? {
        return loginView.passwordTextField.text
    }
    

    
    
    
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }

    //MARK: - Configures

}

extension LoginViewController {
    @objc func signinTapped(sender: UIButton) {
        errorMessage.isHidden = true
        login()
    }
    
    private func login() {
        guard let username = username,!username.isEmpty, let password = password,!password.isEmpty else {
            //비어있을 때 아래의 메세지를
            configureView(withMessage: "절대로 두개중 하나가 비어있으면 안됩니다.")
            return
        }
            //username과 password가 일치하면 signbutton에 indicator를 돌린다.
            if username == "Kevin" && password == "1234" {
                signButton.configuration?.showsActivityIndicator = true
            } else {
                //일치하지 않으면 메세지를 출력
                configureView(withMessage: "User name 혹은 Password를 확인해주세요.")
            }
    }
    
     private func configureView(withMessage  message: String) {
        errorMessage.isHidden = false
        errorMessage.text = message
    }
    
    private func style() {
        //로그인뷰를 자유자재로 움직일 수 있도록 false해줌.
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    private func layout() {
        view.addSubview(loginView)
        view.addSubview(signButton)
        view.addSubview(errorMessage)
        
        //layout 을 active시켜준다.
        //login View
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1),
            
        ])
        //Sign Button
        NSLayoutConstraint.activate([
            signButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
            signButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            signButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
            signButton.heightAnchor.constraint(equalTo: loginView
                .heightAnchor, multiplier: 1 / 2)
        ])
        //ErrorMessage
        NSLayoutConstraint.activate([
            errorMessage.topAnchor.constraint(equalToSystemSpacingBelow: signButton.bottomAnchor, multiplier: 2),
            errorMessage.leadingAnchor.constraint(equalTo: signButton.leadingAnchor),
            errorMessage.trailingAnchor.constraint(equalTo: signButton.trailingAnchor),
            
        ])
    }
    
}

