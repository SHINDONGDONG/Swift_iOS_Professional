//
//  AccountSummaryHeaderView.swift

//

import UIKit

class AccountSummaryHeaderView: UIView {

    //MARK: - Properties
    @IBOutlet var contentView: UIView!
    
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //view사이즈의 초기값 설정
    override var intrinsicContentSize: CGSize {
        //width는 걱정하지마라라 uiview.nointrinsicMetric으로 설정.
        return CGSize(width: UIView.noIntrinsicMetric, height: 144)
    }
    
    
    private func commonInit() {
        //프로메디컬리 하게 번들 클래스자체를 전송한다.
        let bundle = Bundle(for: AccountSummaryHeaderView.self)
        bundle.loadNibNamed("AccountSummaryHeaderView", owner: self, options: nil)
        addSubview(contentView)
        contentView.backgroundColor = appColor
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
}
