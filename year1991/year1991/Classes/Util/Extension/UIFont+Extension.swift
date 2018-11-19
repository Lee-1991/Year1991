//
//  UIFont+Extension.swift
//  year1991
//
//  Created by Lee on 2018/11/19.
//  Copyright © 2018 辛未年. All rights reserved.
//

import UIKit

extension UIFont {
    /// 常规体（Regular）
    ///
    /// - Parameter size: 字体大小
    class func font(_ size:CGFloat) -> UIFont {
        return UIFont.init(name: "PingFangSC-Regular", size: size) ?? UIFont.systemFont(ofSize:size)
    }
    
    /// Medium（Medium）
    ///
    /// - Parameter size: 字体大小
    class func mediumFont(_ size:CGFloat) -> UIFont {
        return UIFont.init(name: "PingFangSC-Medium", size: size) ?? UIFont.boldSystemFont(ofSize:size)
    }
    
    /// Semibold（PingFangSC-Semibold）
    ///
    /// - Parameter size: 字体大小
    class func boldFont(_ size:CGFloat) -> UIFont {
        return UIFont.init(name: "PingFangSC-Semibold", size: size) ?? UIFont.boldSystemFont(ofSize:size)
    }
}
