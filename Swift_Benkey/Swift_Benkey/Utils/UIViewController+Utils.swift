//
//  UIViewController+Utils.swift
//  Swift_Benkey
//
//  Created by 申民鐡 on 2022/07/19.
//

import UIKit

extension UIViewController {
    
    //기본 Bar 스타일
    func setStatusBar() {
        let statusBarSize = UIApplication.shared.statusBarFrame.size //바 사이즈
        let frame = CGRect(origin: .zero, size: statusBarSize) //BarFrame
        let statusbarView = UIView(frame: frame) //UIView의 Frame을 적용
        
        statusbarView.backgroundColor = appColor
        view.addSubview(statusbarView)
    }
    //기본 TabBar 이미지 & 스타일
    func setTabBarImage(imageName: String, title: String) {
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: imageName, withConfiguration: configuration)
        tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
    }
}
