//
//  AccountSummaryViewController.swift
//  Swift_Benkey
//
//  Created by 申民鐡 on 2022/07/19.
//

import UIKit

class AccountSummaryViewController: UIViewController {

    // MARK: - Properties
    var accounts: [AccountSummaryTableViewCell.ViewModel] = []

    let tableView = UITableView()
    
    //logoutbarbutton생성
    lazy var logoutBarButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
        button.tintColor = .label
        return button
    }()
    
    //navigation rightbarbuttonitem을 넣어준다.
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = logoutBarButtonItem
    }
    

    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setupNavigationBar()
    }

    // MARK: - Configures
}

extension AccountSummaryViewController {

    private func setUp(){
        setupTableView()
        setupTableHeaderView()
        fetchData()
    }
    
    private func setupTableHeaderView() {
        //accountsummaryheaderview를 넣어준다.
        let header = AccountSummaryHeaderView(frame: .zero)
        //size에 header.systemlayoutsizefitting을 compress로 넣어줌.
        var size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        //size.width를 현재 단말의 width로 넣어준다.
        size.width = UIScreen.main.bounds.width
        //header 사이즈에 size를 넣는다.
        header.frame.size = size
        
        //tableview의 tableheaderview 에 header를 넣어준다.
        tableView.tableHeaderView = header
    }
    

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = appColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(AccountSummaryTableViewCell.self, forCellReuseIdentifier: AccountSummaryTableViewCell.reuseID)
        tableView.rowHeight = AccountSummaryTableViewCell.rowHeight

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension AccountSummaryViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //accounts가 비어있다면 UITableViewCell을 리턴해주고 끝낸다.
        guard !accounts.isEmpty else { return UITableViewCell() }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryTableViewCell.reuseID, for: indexPath) as? AccountSummaryTableViewCell else { return UITableViewCell() }
        //account에 viewmodel을 하나씩 돌려서 넣어준다.
        let account = accounts[indexPath.row]
        //viewmodel을 넣어서 cell화면에 보내준다.
        cell.configure(vm: account)
        return cell
    }


}

extension AccountSummaryViewController {
    private func fetchData(){
        let savings = AccountSummaryTableViewCell.ViewModel(accountType: .Banking, accountName: "Basic Savings",balance: 17125.22)
        let chequing = AccountSummaryTableViewCell.ViewModel(accountType: .Banking, accountName: "No-Fee All-In Chequing", balance: 60.33)
        let visa = AccountSummaryTableViewCell.ViewModel(accountType: .CreditCard, accountName: "Visa avion Card",balance: 99922.11)
        let masterCard = AccountSummaryTableViewCell.ViewModel(accountType: .CreditCard, accountName: "Student Card", balance: 60.33)
        let investment1 = AccountSummaryTableViewCell.ViewModel(accountType: .Investment, accountName: "Tax-Free Server",balance: 52.2)
        let investment2 = AccountSummaryTableViewCell.ViewModel(accountType: .Investment, accountName: "Growth Fund", balance: 15000.00)
        
        accounts.append(savings)
        accounts.append(chequing)
        accounts.append(visa)
        accounts.append(masterCard)
        accounts.append(investment1)
        accounts.append(investment2)
    }
}


//MARK: - Actions
extension AccountSummaryViewController {
    @objc func logoutTapped(){
        NotificationCenter.default.post(name: .logout, object: nil)
    }

}
