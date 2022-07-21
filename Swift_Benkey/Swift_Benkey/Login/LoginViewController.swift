//
//  ViewController.swift
//  Swift_Benkey
//
//  Created by 申民鐡 on 2022/07/13.
//

import UIKit

protocol logoutDelegate: AnyObject {
    func didLogout()
}

protocol LoginViewControllerDelegate: AnyObject {
    func didLogin()
}

class LoginViewController: UIViewController {

    weak var delegate: LoginViewControllerDelegate?
    
    //MARK: - Properties
    //만들었던 기본적인 loginview를 인스턴스화 시킨다.
    let loginView = LoginView()
    
    lazy var signButton: UIButton = {
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
    
    lazy var descriptionLabel: UILabel = {
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
        label.alpha = 0
        return label
    }()
    
    var username: String? {
        return loginView.usernameTextField.text
    }
    
    var password: String? {
        return loginView.passwordTextField.text
    }
    
    var leadingEdgeOnScreen: CGFloat = 16
    var leadingEdgeOffScreen: CGFloat = -1000
    
    var titleLeadingAnchor: NSLayoutConstraint?
    var subtitleLeadingAnchor: NSLayoutConstraint?
    
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        signButton.configuration?.showsActivityIndicator = false
        loginView.usernameTextField.text = nil
        loginView.passwordTextField.text = nil
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate()
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
        if username == "1" && password == "1" {
            signButton.configuration?.showsActivityIndicator = true
            delegate?.didLogin()
            
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
            titleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
        ])
        
        titleLeadingAnchor = titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
        titleLeadingAnchor?.isActive = true
        
        subtitleLeadingAnchor = descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
        subtitleLeadingAnchor?.isActive = true

    }
    
}

//MARK: - Animate
extension LoginViewController {
    private func animate() {
        let duration = 0.8
        
        //애니메이터 2초의 시간으로 .easeInOut스타일로 애니메이팅이 된다.
        let animator1 = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
        //titleLeadingAncor의 constant가 leading Onscreen 의 위치에 간다.
        self.titleLeadingAnchor?.constant = self.leadingEdgeOnScreen
        //view가 자동으로 레이아웃하거나 업데이트한다면 엔진에대한 신호이다.
        //layoutIfNeeded!!!!!!!!!!중요
        self.view.layoutIfNeeded()
        }
        animator1.startAnimation()
        
        //애니메이터 2초의 시간으로 .easeInOut스타일로 애니메이팅이 된다.
        let animator2 = UIViewPropertyAnimator(duration: duration, curve: .easeInOut) {
        //titleLeadingAncor의 constant가 leading Onscreen 의 위치에 간다.
        self.subtitleLeadingAnchor?.constant = self.leadingEdgeOnScreen
        //view가 자동으로 레이아웃하거나 업데이트한다면 엔진에대한 신호이다.
        //layoutIfNeeded!!!!!!!!!!중요
        self.view.layoutIfNeeded()
        }
        animator2.startAnimation(afterDelay: 0.2)
        
        let animator3 = UIViewPropertyAnimator(duration: duration*2, curve: .easeInOut) {
            self.titleLabel.alpha = 1
            self.view.layoutIfNeeded()
        }
        animator3.startAnimation(afterDelay: 0.2)
    }
}
