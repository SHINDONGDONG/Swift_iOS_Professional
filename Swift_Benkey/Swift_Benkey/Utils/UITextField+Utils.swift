//
//  UITextField+Utils.swift
//  Swift_Benkey
//
//  Created by 申民鐡 on 2022/07/21.
//

import Foundation
import UIKit


let passwordTogleButton = UIButton(type: .custom)

extension UITextField {
    func enablePasswordToggle() {
        //기본 버튼이미지 토글임
        passwordTogleButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        //선택 되었을 때 버튼 셋이미지가 바뀐다.
        passwordTogleButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .selected)
        //버튼이 눌렸을 때
        passwordTogleButton.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        rightView = passwordTogleButton
        //view에 표시하는모드를 정한다.
        rightViewMode = .always
    }
    
    
    @objc func togglePasswordView() {
        //isSecureTextEntry의 현재값의 반대를 만든다
        isSecureTextEntry.toggle()
        //passwordtoglebutton이 isseleced의 반대값을 만든다.
        passwordTogleButton.isSelected.toggle()
    }
}
