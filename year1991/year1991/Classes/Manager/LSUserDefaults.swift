//
//  LSUserDefaluts.swift
//  year1991
//
//  Created by Lee on 2018/11/19.
//  Copyright © 2018 辛未年. All rights reserved.
//

import UIKit

class LSUserDefaults: NSObject {

    
    static let shared = LSUserDefaults()
    private override init() {
        super.init()
    }
    
    /// 存储的key值
    enum Key: String {
        /// 是否登录
        case login = "ap_key_login"
        case token = "ap_key_token"
        case refreshToken = "ap_key_refresh_token"
    }
    
    static func set(_ value: Any?, forKey key: Key) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    static func value(forKey key:Key) -> Any? {
        return UserDefaults.standard.value(forKey: key.rawValue)
    }
    
    static func string(forKey key: Key) -> String? {
        return UserDefaults.standard.string(forKey: key.rawValue)
    }
    
    static func int(forKey key: Key) -> Int {
        return UserDefaults.standard.integer(forKey: key.rawValue)
    }
    
    static func bool(forKey key: Key) -> Bool {
        return UserDefaults.standard.bool(forKey: key.rawValue)
    }
    
  
}
