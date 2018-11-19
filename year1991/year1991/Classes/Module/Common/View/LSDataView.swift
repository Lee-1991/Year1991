//
//  LSDataView.swift
//  year1991
//
//  Created by Lee on 2018/11/19.
//  Copyright © 2018 辛未年. All rights reserved.
//

import UIKit

class LSDataView: UIView {
    
    /// 页面
    enum Page {
        /// 通用
        case common
        /// 相册
        case album
        case feed
        case photo
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(imageView)
        addSubview(contentLbl)
        
        
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-100)
        }
        
        contentLbl.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(20)
        }
        
//        addConstraint(toCenterX: imageView, toCenterY: imageView)
//        addConstraint(toCenterX: contentLbl, toCenterY: nil)
//        addConstraint(with: contentLbl, topView: imageView, leftView: self, bottomView: nil, rightView: self, edgeInset: UIEdgeInsets(top: 10, left: 15, bottom: 0, right: 15))
    }
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
//        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var contentLbl: UILabel = {
        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
        label.contentMode = .center
        label.textColor = UIColor.color("#B2B2B2")
        return label
    }()
    
}

//MARK: 对外接口
extension LSDataView {
    
    /// 空数据内容
    ///
    /// - Parameters:
    ///   - title: 文案
    ///   - image: 图片   
    func viewContent(_ title: String, image: UIImage? = nil) {
        contentLbl.text = title
        imageView.image = image
    }
    
    /// 空数据页面
    ///
    /// - Parameters:
    ///   - errorView: 是否是网络错误页面
    ///   - page: 要展示空数据的页面
    func view(errorView: Bool, page: Page) {
        switch page {
        case .common:
            if errorView {
                viewContent("网络错误", image: nil)
            } else {
                viewContent("没有数据", image: nil)
            }
        case .album:
            if errorView {
                viewContent("网络错误", image: nil)
            } else {
                viewContent("没有数据", image: nil)
            }
        case .feed:
            if errorView {
                viewContent("网络错误", image: nil)
            } else {
                viewContent("没有数据", image: nil)
            }
//            nodata_icon_photo_album
        case .photo:
            if errorView {
                viewContent("网络错误", image: nil)
            } else {
                viewContent("没有数据", image: nil)
            }
        }
    }
}

//MARK: Extension UIView
extension UIView {
    
    fileprivate func addConstraint(width: CGFloat,height:CGFloat) {
        if width>0 {
            addConstraint(NSLayoutConstraint(item: self,
                                             attribute: .width,
                                             relatedBy: .equal,
                                             toItem: nil,
                                             attribute: NSLayoutConstraint.Attribute(rawValue: 0)!,
                                             multiplier: 1,
                                             constant: width))
        }
        if height>0 {
            addConstraint(NSLayoutConstraint(item: self,
                                             attribute: .height,
                                             relatedBy: .equal,
                                             toItem: nil,
                                             attribute: NSLayoutConstraint.Attribute(rawValue: 0)!,
                                             multiplier: 1,
                                             constant: height))
        }
    }
    
    fileprivate func addConstraint(toCenterX xView:UIView?,toCenterY yView:UIView?) {
        addConstraint(toCenterX: xView, constantx: 0, toCenterY: yView, constanty: 0)
    }
    
    fileprivate func addConstraint(toCenterX xView:UIView?,
                       constantx:CGFloat,
                       toCenterY yView:UIView?,
                       constanty:CGFloat) {
        if let xView = xView {
            addConstraint(NSLayoutConstraint(item: xView,
                                             attribute: .centerX,
                                             relatedBy: .equal,
                                             toItem: self,
                                             attribute: .centerX,
                                             multiplier: 1, constant: constantx))
        }
        if let yView = yView {
            addConstraint(NSLayoutConstraint(item: yView,
                                             attribute: .centerY,
                                             relatedBy: .equal,
                                             toItem: self,
                                             attribute: .centerY,
                                             multiplier: 1,
                                             constant: constanty))
        }
    }
    
    fileprivate func addConstraint(to view:UIView,edageInset:UIEdgeInsets) {
        addConstraint(with: view,
                      topView: self,
                      leftView: self,
                      bottomView: self,
                      rightView: self,
                      edgeInset: edageInset)
    }
    
    fileprivate func addConstraint(with view:UIView,
                                   topView:UIView?,
                                   leftView:UIView?,
                                   bottomView:UIView?,
                                   rightView:UIView?,
                                   edgeInset:UIEdgeInsets) {
        if let topView = topView {
            addConstraint(NSLayoutConstraint(item: view,
                                             attribute: .top,
                                             relatedBy: .equal,
                                             toItem: topView,
                                             attribute: .top,
                                             multiplier: 1,
                                             constant: edgeInset.top))
        }
        if let leftView = leftView {
            addConstraint(NSLayoutConstraint(item: view,
                                             attribute: .left,
                                             relatedBy: .equal,
                                             toItem: leftView,
                                             attribute: .left,
                                             multiplier: 1,
                                             constant: edgeInset.left))
        }
        if let bottomView = bottomView {
            addConstraint(NSLayoutConstraint(item: view,
                                             attribute: .bottom,
                                             relatedBy: .equal,
                                             toItem: bottomView,
                                             attribute: .bottom,
                                             multiplier: 1,
                                             constant: edgeInset.bottom))
        }
        if let rightView = rightView {
            addConstraint(NSLayoutConstraint(item: view,
                                             attribute: .right,
                                             relatedBy: .equal,
                                             toItem: rightView,
                                             attribute: .right,
                                             multiplier: 1,
                                             constant: edgeInset.right))
        }
    }
}


