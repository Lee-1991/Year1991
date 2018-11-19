//
//  APConfig.swift
//  ActiveProject
//
//  Created by Lee on 2018/8/10.
//  Copyright © 2018年 7moor. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftyJSON
import Photos
import Qiniu
import SnapKit

//屏幕宽高
let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height

/// 宽度适配参数
let kWidth: CGFloat = kScreenWidth/375.0
/// 高度适配参数
let kHeight: CGFloat = kScreenHeight/667.0

/// 状态栏高度
let kStatusBarHeight = UIApplication.shared.statusBarFrame.size.height
/// 导航栏高度(包括了状态栏的高度)
let kNavBarHeight:CGFloat = kStatusBarHeight + 44.0

/// tabbar高度
let kTabBarHeight:CGFloat = kStatusBarHeight > 20 ? 83:49

/// 底部安全区域的高度
let kSafeAreaHeight:CGFloat = kStatusBarHeight > 20 ? 34:0

let kMargin: CGFloat = 10

class APConfig: NSObject {

    //FIXME: 发布版本的时候务必修改服务器环境
    /// 服务器环境是否是正式环境
    static func serverEnvironmentFormal()->Bool{
        return false
    }
}

/// 日志打印
///
/// - parameter message:  日志消息
/// - parameter file:     文件名
/// - parameter method:   方法名
/// - parameter line:     代码行数
func APLog<T>(_ message: T,
                file: String = #file,
                method: String = #function,
                line: Int = #line)
{
    #if DEBUG
        print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(String(describing:  message))")
    #endif
}
