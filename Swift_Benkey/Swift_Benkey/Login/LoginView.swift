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
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 200)
    }
    
    //MARK: - Configures

}

extension LoginView {
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemPink
        usernameTextField.delegate = self
        addSubview(usernameTextField)
        
    }
    func layout() {
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            usernameTextField.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: usernameTextField.trailingAnchor, multiplier: 1)
        ])
        
    }
}

extension LoginView:UITextFieldDelegate {
    
    //텍스트필드 사용을 마치고 return하면 endEdting이 실행
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTextField.endEditing(true)
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
