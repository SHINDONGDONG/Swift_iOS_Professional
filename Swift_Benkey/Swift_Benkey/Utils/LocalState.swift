//
//  LocalState.swift
//  Swift_Benkey
//
//  Created by 申民鐡 on 2022/07/15.
//

import Foundation

public class LocalState {
    
    private enum Keys: String {
        case hasOnboared
    }
    
    public static var hasOnboared: Bool {
        
        //기억하고있는 keys.hasonboared.rawvalue를 가져온다..
        get {
            return UserDefaults.standard.bool(forKey: Keys.hasOnboared.rawValue)
        }
        //userdefaults에 setting을 하여 값을 바꾸어준다.
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: Keys.hasOnboared.rawValue)
//            UserDefaults.standard.synchronize()
        }
    }
    
    
    
}
