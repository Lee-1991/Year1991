//
//  UIButton+Extension.swift
//  year1991
//
//  Created by Lee on 2018/11/19.
//  Copyright © 2018 辛未年. All rights reserved.
//

import UIKit



extension UIButton{
    
    /// 按钮布局样式（图片+文字）
    enum LayoutStyle:UInt8 {
        ///图片在上面
        case imageTop
        ///图片在下面
        case imageBottom
        ///图片在左边
        case imageLeft
        ///图片在右边
        case imageRight
    }
    
    /// 按钮的文字与图片位置布局,（在布局完以后再调用此方法，不然UI上可能会出错）
    ///
    /// - Parameters:
    ///   - style: 样式
    ///   - padding: 间距（图片与文字间的间距）
    func layout(_ style: LayoutStyle, padding: CGFloat = 2.0){
        self.contentMode = .center
        /**
         *  知识点：titleEdgeInsets是title相对于其上下左右的inset，跟tableView的contentInset是类似的，
         *  如果只有title，那它上下左右都是相对于button的，image也是一样；
         *  如果同时有image和label，那这时候image的上左下是相对于button，右边是相对于label的；title的上右下是相对于button，左边是相对于image的。
         */
        // 1. 得到imageView和titleLabel的宽、高
        let imageWith = self.imageView?.frame.size.width ?? 0.0
        let imageHeight = self.imageView?.frame.size.height ?? 0.0
        let labelWidth = self.titleLabel?.intrinsicContentSize.width ?? 0.0
        let labelHeight = self.titleLabel?.intrinsicContentSize.height ?? 0.0
        
        // 2. 声明imageEdgeInsets和labelEdgeInsets
        var imageEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets = UIEdgeInsets.zero
        
        // 3. 根据style和padding得到imageEdgeInsets和labelEdgeInsets的值
        switch style {
        case .imageTop:
            imageEdgeInsets = UIEdgeInsets(top: -labelHeight-padding/2.0, left: 0, bottom: 0, right: -labelWidth/2);
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWith, bottom: -imageHeight-padding/2.0, right: 0);
        case .imageBottom:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight-padding/2.0, right: -labelWidth);
            labelEdgeInsets = UIEdgeInsets(top: -imageHeight-padding/2.0, left: -imageWith, bottom: 0, right: 0);
        case .imageLeft:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -padding/2.0, bottom: 0, right: padding/2.0);
            labelEdgeInsets = UIEdgeInsets(top: 0, left: padding/2.0, bottom: 0, right: -padding/2.0);
        case .imageRight:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth+padding/2.0, bottom: 0, right: -(labelWidth+padding/2.0));
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -(imageWith+padding/2.0), bottom: 0, right: imageWith+padding/2.0);
        }
        
        // 4. 赋值
        self.titleEdgeInsets = labelEdgeInsets;
        self.imageEdgeInsets = imageEdgeInsets;
        
    }
    
}

