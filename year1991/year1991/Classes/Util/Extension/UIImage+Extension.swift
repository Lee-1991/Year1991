//
//  UIImage+Extension.swift
//  year1991
//
//  Created by Lee on 2018/11/19.
//  Copyright © 2018 辛未年. All rights reserved.
//

import UIKit

extension UIImage {
    
    /// 绘制纯色图片
    class func image(_ color: UIColor, viewSize: CGSize = CGSize(width: 10, height: 10)) -> UIImage{
        let rect: CGRect = CGRect(x: 0, y: 0, width: viewSize.width, height: viewSize.height)
        UIGraphicsBeginImageContext(rect.size)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsGetCurrentContext()
        return image!
    }
    
    /// 原图
    ///
    /// - Returns: RenderingMode 为.alwaysOriginal 的图片
    class func originalImage(_ named: String) -> UIImage? {
        let image = UIImage(named: named)?.withRenderingMode(.alwaysOriginal)
        return image
    }
}
