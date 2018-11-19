//
//  LSUtilDate.swift
//  year1991
//
//  Created by Lee on 2018/11/19.
//  Copyright © 2018 辛未年. All rights reserved.
//
import UIKit

class LSUtilDate: NSObject {
    
    /// 当前时间戳
    static func nowIntervalStr() -> String {
        let interval = Date().timeIntervalSince1970
        return String(interval)
    }
    
    /// 将时间戳转换为yyyy-MM-dd HH:mm:ss格式
    static func dateString(timeInterval str: String?) -> String {
        guard let str = str else {
            APLog("时间戳 = nil")
            return ""
        }
        guard let interval = Double(str) else {
            APLog("\(str)不是一个时间戳")
            return str
        }
        
        let date = Date(timeIntervalSince1970: interval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateStr = dateFormatter.string(from: date)
        return dateStr
    }
    
    /// 将时间戳转换为yyyy-MM-dd HH:mm:ss格式
    static func dateString(from timeInterval: TimeInterval?) -> String {
        guard let interval = timeInterval else {
            APLog("时间戳 = nil")
            return ""
        }
        let date = Date(timeIntervalSince1970: interval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateStr = dateFormatter.string(from: date)
        return dateStr
    }

}
