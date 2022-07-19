//
//  CurencyFormatter.swift
//  Swift_Benkey
//
//  Created by 申民鐡 on 2022/07/20.
//

import Foundation

import UIKit

struct CurrencyFormatter {
    
    //decimal 데이터를 받아서 튜플에 옮겨준다.
    func makeAttributedCurrency(_ amount: Decimal) -> NSMutableAttributedString {
        let tuple = breakIntoDollarsAndCents(amount)
        return makeBalanceAttributed(dollars: tuple.0, cents: tuple.1)
    }
    
    // Converts 929466.23 > "929,466" "23"
    //decimal 데이터를받아서 스트링으로 리턴해주는데 doublevalue로 바꾸어 저장한다.
    //이 때 달러는 튜플0, 센트는 튜플1 리턴을 해준다.
    func breakIntoDollarsAndCents(_ amount: Decimal) -> (String, String) {
        let tuple = modf(amount.doubleValue)
        
        let dollars = convertDollar(tuple.0)
        let cents = convertCents(tuple.1)
        
        return (dollars, cents)
    }
    
    // Converts 929466 > 929,466
    //더블로받은 dollar는
    private func convertDollar(_ dollarPart: Double) -> String {
        let dollarsWithDecimal = dollarsFormatted(dollarPart) // "$929,466.00"
        let formatter = NumberFormatter()
        // .을 넣어준다
        let decimalSeparator = formatter.decimalSeparator! // "."
        // .을 기준으로 나눠준다.
        let dollarComponents = dollarsWithDecimal.components(separatedBy: decimalSeparator) // "$929,466" "00"
        //dollar만 넣어준다.
        var dollars = dollarComponents.first! // "$929,466"
        dollars.removeFirst(3)

        return dollars
    }
    
    // Convert 0.23 > 23
    private func convertCents(_ centPart: Double) -> String {
        let cents: String
        print(centPart)
        if centPart == 0 {
            cents = "00"
        } else {
            cents = String(format: "%.0f", centPart * 100)
        }
        return cents
    }
    
    // Converts 929466 > $929,466.00
    func dollarsFormatted(_ dollars: Double) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        
        if let result = formatter.string(from: dollars as NSNumber) {
            return result
        }
        
        return ""
    }
    
    private func makeBalanceAttributed(dollars: String, cents: String) -> NSMutableAttributedString {
        let dollarSignAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
        let dollarAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .title1)]
        let centAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
        
        let rootString = NSMutableAttributedString(string: "$", attributes: dollarSignAttributes)
        let dollarString = NSAttributedString(string: dollars, attributes: dollarAttributes)
        let centString = NSAttributedString(string: cents, attributes: centAttributes)
        
        rootString.append(dollarString)
        rootString.append(centString)
        
        return rootString
    }
}
