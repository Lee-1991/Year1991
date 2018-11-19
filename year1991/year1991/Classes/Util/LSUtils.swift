//
//  LSUtils.swift
//  year1991
//
//  Created by Lee on 2018/11/19.
//  Copyright © 2018 辛未年. All rights reserved.
//

import UIKit


/// 延时执行
///
/// - Parameters:
///   - duration: 延时时长
func asyncAfter(duration:TimeInterval,
                                completion:(() -> Void)?) {
    DispatchQueue.main.asyncAfter(deadline: .now() + duration,
                                  execute: {
                                    completion?()
    })
}


/// 主线程
func async(_ comletion:(() -> Void)?) {
    DispatchQueue.main.async {
        comletion?()
    }
}

class APUtils: NSObject {

}
