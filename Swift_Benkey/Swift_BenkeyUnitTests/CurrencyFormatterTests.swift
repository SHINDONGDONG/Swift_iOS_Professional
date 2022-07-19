//
//  CurrencyFormatterTests.swift
//  Swift_BenkeyUnitTests
//
//  Created by 申民鐡 on 2022/07/21.
//

import Foundation
//Test할 때 필요함.
import XCTest

//Swift_Benkey를 엑세스 할 수 있게 만들어주는것.
@testable import Swift_Benkey

class CurrencyFormatterTests: XCTestCase {
    //테스트할 스위프트 파일을 가져온다
    var formatter: CurrencyFormatter!

    override func setUp() {
        super.setUp()
        //formatter에 currencyFormatter를 넣어줌.
        formatter = CurrencyFormatter()
    }
    
    //test 항목을 만들고 예상되는 결과값을 넣어준다.
    func testbreakIntoDollarsAndCents() throws{
        //본 메서드는 달러와,센트를 따로 저장시켜주는 기능이기때문에
        //XCTAssertEqual을 사용하여 result에 저장되어있는 0,1 값 예상값을 넣어준다.
        let result = formatter.breakIntoDollarsAndCents(999922.11)
        XCTAssertEqual(result.0, "999,922")
        XCTAssertEqual(result.1, "11")
    }
    
    
    func testdollarsFormatted() throws {
        let result = formatter.dollarsFormatted(929446)
        XCTAssertEqual(result, "US$929,446.00")
    }
    
    func testZerodollarsFormatted() throws {
        let result = formatter.dollarsFormatted(0)
        let locale = Locale.current.currencySymbol!
        XCTAssertEqual(result, "\(locale)0.00")
    }
    
    func testDollarsFormatteredWithCurrencySymbol() throws {
        let local = Locale.current
        let currencySymbol = local.currencySymbol!
        
        let result = formatter.dollarsFormatted(99922.11)
        XCTAssertEqual(result, "\(currencySymbol)99,922.11")
    }

}
 

//// Converts 929466 > $929,466.00
//func dollarsFormatted(_ dollars: Double) -> String {
//    let formatter = NumberFormatter()
//    formatter.numberStyle = .currency
//    formatter.usesGroupingSeparator = true
//
//    if let result = formatter.string(from: dollars as NSNumber) {
//        return result
//    }
//
//    return ""
//}


//func breakIntoDollarsAndCents(_ amount: Decimal) -> (String, String) {
//    let tuple = modf(amount.doubleValue)
//
//    let dollars = convertDollar(tuple.0)
//    let cents = convertCents(tuple.1)
//
//    return (dollars, cents)
//}

