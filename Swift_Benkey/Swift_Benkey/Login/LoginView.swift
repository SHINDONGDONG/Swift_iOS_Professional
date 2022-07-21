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
        textfield.keyboardType = .asciiCapable
        textfield.autocorrectionType = .no
        return textfield
    }()
    
    let passwordTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Password"
        textfield.translatesAutoresizingMaskIntoConstraints = false
        //password로 SecureTextEntry임.
        textfield.isSecureTextEntry = true
        textfield.enablePasswordToggle()
        return textfield
    }()
    
    let dividerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemFill
        return view
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
        backgroundColor = .secondarySystemBackground
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        //layer.cornerRaidus 는 모서리를 둥글게
        layer.cornerRadius = 10
        //다른배경을 자르거나 주위를 자르는것을 의미 clipstoBounds
        clipsToBounds = true
    }

    func layout() {
        addSubview(stackView)
        //스택뷰에 들어올 것들을 여기에 추가해준다.
        stackView.addArrangedSubview(usernameTextField)
        stackView.addArrangedSubview(dividerView)
        stackView.addArrangedSubview(passwordTextField)
        
        
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 1),
            bottomAnchor.constraint(equalToSystemSpacingBelow: stackView.bottomAnchor, multiplier: 1)
        ])
        
        //구분선을 height 1로 주고 active를 true로 한다.
        dividerView.heightAnchor.constraint(equalToConstant: 1).isActive = true
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
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
}
