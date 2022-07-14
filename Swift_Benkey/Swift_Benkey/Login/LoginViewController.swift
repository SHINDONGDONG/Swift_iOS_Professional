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
    
    let descriptionLabel: UILabel = {
       let label = UILabel()
        label.text = "Your Benkey My Mind All right Cool Your Benkey My Mind All right Cool Your Benkey My Mind All right Cool"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(forTextStyle: .title3)
        return label
    }()
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Benkey"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.adjustsFontForContentSizeCategory = true
        return label
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
        view.addSubview(descriptionLabel)
        view.addSubview(titleLabel)
        
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
        //descriptionLabel
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalToSystemSpacingBelow: descriptionLabel.bottomAnchor, multiplier: 3),
            descriptionLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
        ])
        
        //title Label
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 3),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            

        ])

    }
    
}

