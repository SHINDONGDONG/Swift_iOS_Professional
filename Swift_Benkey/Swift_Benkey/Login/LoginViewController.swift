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
        view.endEditing(true)
        errorMessage.isHidden = true
        login()
    }
    
    private func login() {
        //usernmae passwordを受け取ってEmptyか検証し空ではなければデータを格納、空の場合ErrorMessageを出力
        guard let username = username, !username.isEmpty, let password = password,!password.isEmpty else {
            configureView(withMessage: "UsernameもしくはPasswordを入力してください。")
            return
        }
        
        //Username or Passwordが間違っているときError Messageを出力
        if username == "kevin" && password == "kevin" {
            signButton.configuration?.showsActivityIndicator = true
        } else {
            configureView(withMessage: "UsernameもしくはPasswordをご確認ください。")
        }
        
        //Username or Passwordが５桁より短い場合出力
        if username.count < 4 {
            configureView(withMessage: "Usernameは5桁以上必須")
        }else if password.count < 4 {
            configureView(withMessage: "Passwordは5桁以上必須")
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

