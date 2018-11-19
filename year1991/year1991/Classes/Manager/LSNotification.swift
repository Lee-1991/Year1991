//
//  LSNotification.swift
//  year1991
//
//  Created by Lee on 2018/11/19.
//  Copyright © 2018 辛未年. All rights reserved.
//

import UIKit

struct LSNotificationName {
    static let kTabbarBadge = NSNotification.Name(rawValue: "kNotificationTabbarBadge")
}

class LSNotification: NSNotification {
    
    
    
    /// Tabbar的badge 文字
    static func showTabbarBadge(_ show: Bool = true, at index: Int, content: String = "") {
        let dic = ["show":show,
                   "index":index,
                   "number":0,
                   "content":content] as [String : Any]
        NotificationCenter.default.post(name: LSNotificationName.kTabbarBadge, object: dic)
    }
    
    /// Tabbar的badge 数字
    static func showTabbarBadge(_ show: Bool = true, at index: Int, number: Int) {
        let dic = ["show":show,
                   "index":index,
                   "number":number,
                   "content":""] as [String : Any]
        NotificationCenter.default.post(name: LSNotificationName.kTabbarBadge, object: dic)
    }
    
    /// 隐藏Tabbar的badge
    static func hiddenTabbarBadge(at index: Int) {
        let dic = ["show":false,
                   "index":index,
                   "number":0,
                   "content":""] as [String : Any]
        NotificationCenter.default.post(name: LSNotificationName.kTabbarBadge, object: dic)
    }

}
