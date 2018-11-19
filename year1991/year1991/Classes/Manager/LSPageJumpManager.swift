//
//  LSPageJumpManager.swift
//  year1991
//
//  Created by Lee on 2018/11/19.
//  Copyright © 2018 辛未年. All rights reserved.
//

import UIKit



class LSPageJumpManager: NSObject {
    
    /// 当前跳转控制器
    static func currentNav() -> UINavigationController? {
        
        let vc = UIApplication.shared.keyWindow?.rootViewController
        guard let root = vc else { return nil }
        var nav: UINavigationController?
        
        if root.isKind(of: UITabBarController.self) {
            let tvc = root as! UITabBarController
            nav = tvc.selectedViewController as? UINavigationController
        }
        
        guard nav != nil else {
            return UIViewController.current()?.navigationController
        }
        return nav
    }
    
    static func pushViewController(_ viewController: UIViewController, animated: Bool = true) {
        currentNav()?.pushViewController(viewController, animated: animated)
    }

    /// web页面
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - linkUrl: 链接
    static func pushToWebVC(_ title: String = "", linkUrl:String) {
        let vc = LSWebViewController()
        vc.titleStr = title
        vc.linkUrl = linkUrl
        pushViewController(vc)
    }

    
    /// 关于页面
    static func pushToAboutVC(){
        let vc = LSAboutViewController()
        pushViewController(vc)
    }
    
 
}
