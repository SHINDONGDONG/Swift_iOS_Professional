//
//  DecimalUtils.swift
//  Swift_Benkey
//
//  Created by 申民鐡 on 2022/07/20.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        //decimal을 가져와서 doubleValue에 담아준다(double타입으로 형변환)
        return NSDecimalNumber(decimal:self).doubleValue
    }
}
