//
//  DummyViewController.swift
//  Swift_Benkey
//
//  Created by 申民鐡 on 2022/07/15.
//

import UIKit



class DummyViewController: UIViewController {

    // MARK: - Properties
    weak var logoutDelegate: logoutDelegate? 
    
    let stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 20
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Welecom"
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Logout", for: [])
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        button.addTarget(self, action: #selector(logoutButtonTapped), for: .primaryActionTriggered)
        return button
    }()
    
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    

    // MARK: - Config
    
    private func layout(){
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
                
    }
    private func style(){
        view.backgroundColor = .systemBackground
        view.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(logoutButton)
    }

}

extension DummyViewController {
    //actions
    @objc func logoutButtonTapped() {
        logoutDelegate?.didLogout()
    }
}
