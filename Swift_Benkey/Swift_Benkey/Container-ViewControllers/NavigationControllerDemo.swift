//
//  NavigationControllerDemo.swift
//  Swift_Benkey
//
//  Created by 申民鐡 on 2022/07/15.
//

import UIKit

class NavigationControllerDemo: UIViewController {

    // MARK: - Properteis
    let stackView = UIStackView()
    let pushButton = UIButton(type: .system)
    let presentButton = UIButton(type: .system)
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
        layout()
        style()
    }
    

    private func style(){
        title = "NaviBAR"
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        pushButton.translatesAutoresizingMaskIntoConstraints = false
        pushButton.configuration = .filled()
        pushButton.setTitle("Push", for: [])
        pushButton.addTarget(self, action: #selector(pushTapped), for: .primaryActionTriggered)
        
        presentButton.translatesAutoresizingMaskIntoConstraints = false
        presentButton.configuration = .filled()
        presentButton.setTitle("Present", for: [])
        presentButton.addTarget(self, action: #selector(presentTapped), for: .primaryActionTriggered)
        
    }
    private func layout(){
        view.addSubview(stackView)
        stackView.addArrangedSubview(pushButton)
        stackView.addArrangedSubview(presentButton)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func pushTapped(sender: UIButton) {
        navigationController?.pushViewController(PushViewController(), animated: true)
    }
    
    @objc func presentTapped(sender: UIButton) {
        let navVC = UINavigationController(rootViewController: PresentViewController())
        present(navVC, animated: true)
    }
}


class PushViewController: UIViewController {
    let stackView = UIStackView()
    let popButton = UIButton(type: .system)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    private func style(){
        title = "Pushed View Cotnroller"
        view.backgroundColor = .systemOrange
        view.addSubview(popButton)
    }
    
    private func layout() {
        popButton.setTitle("Back", for: .normal)
        popButton.translatesAutoresizingMaskIntoConstraints = false
        popButton.configuration = .filled()
        popButton.addTarget(self, action: #selector(popMenu), for: .primaryActionTriggered)
        
        NSLayoutConstraint.activate([
            popButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            popButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    @objc func popMenu(){
        self.navigationController?.popViewController(animated: true)
    }
}

class PresentViewController: UIViewController {
    let stackView = UIStackView()
    let popButton = UIButton(type: .system)
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    private func style(){
        title = "Present View Cotnroller"
        view.backgroundColor = .systemPink
        
        popButton.translatesAutoresizingMaskIntoConstraints = false
        popButton.setTitle("Pop", for: [])
        popButton.configuration = .filled()
        popButton.addTarget(self, action: #selector(clickedPop), for: .primaryActionTriggered)
    }
    @objc func clickedPop() {
        self.dismiss(animated: true)
    }
    
    private func layout() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(popButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
