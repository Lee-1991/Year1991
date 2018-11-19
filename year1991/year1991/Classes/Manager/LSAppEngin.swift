//
//  LSAppEngin.swift
//  year1991
//
//  Created by Lee on 2018/11/19.
//  Copyright © 2018 辛未年. All rights reserved.
//

import UIKit

class AppEngin: NSObject {
    
    static let shared = AppEngin()
    private override init() {
        super.init()
    }
    
    var uid = ""
    

    var token: String?
}
