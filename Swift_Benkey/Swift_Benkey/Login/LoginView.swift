//
//  LoginView.swift
//  Swift_Benkey
//
//  Created by 申民鐡 on 2022/07/13.
//

import UIKit

class LoginView: UIView {
    //MARK: - Properties
    let usernameTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Username"
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    let passwordTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Password"
        textfield.translatesAutoresizingMaskIntoConstraints = false
        //password로 SecureTextEntry임.
        textfield.isSecureTextEntry = true
        return textfield
    }()
    
    let stackView:UIStackView = {
        let stack = UIStackView()
        //const 사용하기위해 false
        stack.translatesAutoresizingMaskIntoConstraints = false
        //방향
        stack.axis = .vertical
        //스택뷰끼리 간격
        stack.spacing = 8
        return stack
    }()
    
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        //Extension 으로 style, layout을 만들어놓는다.
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        //기본 CGSize지정.
//    override var intrinsicContentSize: CGSize {
//        return CGSize(width: 200, height: 200)
//    }
    
    //MARK: - Configures

}

extension LoginView {
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemOrange
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }

    func layout() {
        addSubview(stackView)
        //스택뷰에 들어올 것들을 여기에 추가해준다.
        stackView.addArrangedSubview(usernameTextField)
        stackView.addArrangedSubview(passwordTextField)
        
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1)
        ])
        
    }
}

extension LoginView:UITextFieldDelegate {
    
    //텍스트필드 사용을 마치고 return하면 endEdting이 실행
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTextField.endEditing(true)
        passwordTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Username"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
}
