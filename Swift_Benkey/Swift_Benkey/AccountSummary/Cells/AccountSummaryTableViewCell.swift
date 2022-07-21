//
//  AccountSummaryTableViewCell.swift
//  Swift_Benkey
//
//  Created by 申民鐡 on 2022/07/19.
//

import UIKit

class AccountSummaryTableViewCell: UITableViewCell {
    
    enum AccountType: String {
        case Banking
        case CreditCard
        case Investment
    }
    
    struct ViewModel {
        let accountType: AccountType
        let accountName: String
        let balance: Decimal
        
        var balanceAsAttributedString: NSAttributedString{
            return CurrencyFormatter().makeAttributedCurrency(balance)
        }
    }
    //viewModel을 초기화함 처음에는 nil이 들어가있다.
    let viewModel: ViewModel? = nil
    
    
    static let reuseID = "AccountSummaryTableViewCell"
    static let rowHeight: CGFloat = 112
    
    let typeLabel = UILabel()
    let underLineView = UIView(frame: .zero)
    let nameLabel = UILabel()
    
    let balanceStackView = UIStackView()
    let balanceLabel = UILabel()
    let balanceAmountLabel = UILabel()
    let chevronImageView = UIImageView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension AccountSummaryTableViewCell {
    private func setup(){
        balanceStackView.translatesAutoresizingMaskIntoConstraints = false
        balanceStackView.spacing = 0
        balanceStackView.axis = .vertical
        
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceLabel.font = .preferredFont(forTextStyle: .body)
        balanceLabel.textAlignment = .right
        balanceLabel.adjustsFontSizeToFitWidth = true
//        balanceLabel.text = "Some Balance"
        
        balanceAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceAmountLabel.textAlignment = .right
//        balanceAmountLabel.text = "XXXX.XX"
        
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        //컬러를 언제나 오리지날 색상으로 만든다.
        let chevron = UIImage(systemName: "chevron.right")!.withTintColor(appColor,renderingMode: .alwaysOriginal)
        chevronImageView.image = chevron
        
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.font = .preferredFont(forTextStyle: .caption1)
        typeLabel.adjustsFontSizeToFitWidth = true
//        typeLabel.text = "Account Type"
        
        underLineView.translatesAutoresizingMaskIntoConstraints = false
        underLineView.backgroundColor = .systemTeal
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .preferredFont(forTextStyle: .body)
//        nameLabel.text = "Account Name"
        nameLabel.adjustsFontSizeToFitWidth = true
        
        contentView.addSubview(balanceStackView)
        balanceStackView.addArrangedSubview(balanceLabel)
        balanceStackView.addArrangedSubview(balanceAmountLabel)
        contentView.addSubview(chevronImageView)
        
        contentView.addSubview(typeLabel)
        contentView.addSubview(underLineView)
        contentView.addSubview(nameLabel)
    }
    private func layout(){
        //typeLabel
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            typeLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2)
        ])
        //UnderLine UiView
        NSLayoutConstraint.activate([
            underLineView.topAnchor.constraint(equalToSystemSpacingBelow: typeLabel.bottomAnchor, multiplier: 1),
            underLineView.leadingAnchor.constraint(equalTo: typeLabel.leadingAnchor),
            underLineView.heightAnchor.constraint(equalToConstant: 4),
            underLineView.widthAnchor.constraint(equalToConstant: 60)
        ])
        //nameLabel
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalToSystemSpacingBelow: underLineView.bottomAnchor, multiplier: 2),
            nameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2)
        ])
        
        //balanceStackView
        NSLayoutConstraint.activate([
            balanceStackView.topAnchor.constraint(equalToSystemSpacingBelow: underLineView.bottomAnchor, multiplier: 0),
            balanceStackView.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 4),
            trailingAnchor.constraint(equalToSystemSpacingAfter: balanceStackView.trailingAnchor, multiplier: 4)
        ])
        //chevronImage
        NSLayoutConstraint.activate([
            chevronImageView.topAnchor.constraint(equalToSystemSpacingBelow: underLineView.bottomAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: chevronImageView.trailingAnchor, multiplier: 1)
        ])
    }
    
    //   달러와 센트를 다르게 집어넣을 것이다.
    private func makeFormattedBalance(dollars: String, cents: String) -> NSMutableAttributedString {
        //달러표시를 넣어주는 atrributes이다. baselinoffset은 8로 위로올라가게만듬.
        let dollarSignAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
        //dollar의 속성을 정해주는것이다.
        let dollarAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .title1)]
        let centAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .footnote), .baselineOffset: 8]
        
        //root스트링에 $표시를 넣어주고 달러속성을 attributes로 적용시켜준다 다른것들도 마찬가지
        let rootString = NSMutableAttributedString(string: "$", attributes: dollarSignAttributes)
        let dollarString = NSAttributedString(string: dollars, attributes: dollarAttributes)
        let centString = NSAttributedString(string: cents, attributes: centAttributes)
        
        //rootstring에 추가를 시켜준다.
        rootString.append(dollarString)
        rootString.append(centString)
        
        return rootString
    }
}

extension AccountSummaryTableViewCell {
    func configure(vm: ViewModel) {
        //배열순서대로 typelabel, namelabel을 넣어주고
        typeLabel.text = vm.accountType.rawValue
        nameLabel.text = vm.accountName
        balanceAmountLabel.attributedText = vm.balanceAsAttributedString
        
        switch vm.accountType {
        case .Banking:
            //뱅킹일때의 color, balaceLabel을 정해준다
            underLineView.backgroundColor = appColor
            balanceLabel.text = "Current Balance"
        case .CreditCard:
            //CreditCard일때 color, balaceLabel을 정해준다
            underLineView.backgroundColor = .systemOrange
            balanceLabel.text = "Current Balance"
        case .Investment:
            //Investement일 때 color, balaceLabel을 정해준다
            underLineView.backgroundColor = .systemPurple
            balanceLabel.text = "Value"
        }
    }
}
