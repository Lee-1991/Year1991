//
//  UIView+Extension.swift
//  year1991
//
//  Created by Lee on 2018/11/19.
//  Copyright © 2018 辛未年. All rights reserved.
//

import UIKit

extension UIView {
    /// 分割线
    static func initSeparateLine() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.color("#E5E5E5")
        return view
    }
    
    
    /// 添加指定角的圆角，添加前要先设置frame
    ///
    /// - Parameters:
    ///   - roundingCorners: let corner:UIRectCorner = [.topLeft,.topRight]
    ///   - cornerRadius: 圆角弧度
    func addCorner(_ roundingCorners: UIRectCorner, cornerRadius: CGFloat) {
        let cornerSize = CGSize(width: cornerRadius, height: cornerRadius)
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: roundingCorners, cornerRadii: cornerSize)
        let cornerLayer = CAShapeLayer()
        cornerLayer.frame = bounds
        cornerLayer.path = path.cgPath
        layer.mask = cornerLayer
    }
    
//    @discardableResult
//    func setGradient(colors: [UIColor], startPoint: CGPoint ,endPoint: CGPoint) -> CAGradientLayer {
//        func setGradient(_ layer: CAGradientLayer) {
//            self.layoutIfNeeded()
//            var colorArr = [CGColor]()
//            for color in colors {
//                colorArr.append(color.cgColor)
//            }
//            CATransaction.begin()
//            CATransaction.setDisableActions(true)
//            layer.frame = self.bounds
//            CATransaction.commit()
//
//            layer.colors = colorArr
//            layer.startPoint = startPoint
//            layer.endPoint = endPoint
//        }
//        var gradientLayerStr = "gradientLayerStr"
//        if let gradientLayer = objc_getAssociatedObject(self, &gradientLayerStr) as? CAGradientLayer {
//            setGradient(gradientLayer)
//            return gradientLayer
//        }else {
//            let gradientLayer = CAGradientLayer()
//            self.layer.insertSublayer(gradientLayer , at: 0)
//            setGradient(gradientLayer)
//            objc_setAssociatedObject(self, &gradientLayerStr, gradientLayer, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            return gradientLayer
//        }
//    }
}
