//
//  LSShareView.swift
//  year1991
//
//  Created by Lee on 2018/11/19.
//  Copyright © 2018 辛未年. All rights reserved.
//
//  分享面板

import UIKit

//屏幕宽高
fileprivate let kShareViewWidth = UIScreen.main.bounds.size.width
fileprivate let kShareViewHeight = UIScreen.main.bounds.size.height
fileprivate let kContentHeight: CGFloat = 164

class LSShareView: UIView {
    
    fileprivate let ShareItemDefalutTag = 1991
    
    fileprivate var shareContent: String = ""
    fileprivate var shareTitle: String = ""
    fileprivate var shareDescribe: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: kShareViewWidth, height: kShareViewHeight))
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = UIColor.color("#000000", alpha: 0.01)
        self.addGestureRecognizer(tapGesture)
        self.addSubview(contentView)
        
        contentView.addSubview(cancelBtn)
        
        let margin: CGFloat = 18
        let itemWidth: CGFloat = 51
//        let itemHeight: CGFloat = 70
        var orignalX = margin
        let orignalY: CGFloat = 27
        
        for item in itemDatas.enumerated() {
            let shareItem = UIButton(frame: CGRect(x: orignalX, y: orignalY, width: itemWidth, height: itemWidth))
            shareItem.tag = ShareItemDefalutTag + item.offset
            shareItem.setImage(item.element.icon, for: .normal)
            shareItem.addTarget(self, action: #selector(onClickShareItemButton(_:)), for: .touchUpInside)
            contentView.addSubview(shareItem)
            
            let shareTitle = UIButton()
            shareTitle.tag = ShareItemDefalutTag + item.offset
            shareTitle.titleLabel?.font = UIFont.font(10)
            shareTitle.setTitleColor(UIColor.color("#9B9B9B"), for: .normal)
            shareTitle.setTitle(item.element.name, for: .normal)
            shareTitle.addTarget(self, action: #selector(onClickShareItemButton(_:)), for: .touchUpInside)
            contentView.addSubview(shareTitle)
            shareTitle.snp.makeConstraints { (make) in
                make.centerX.equalTo(shareItem)
                make.top.equalTo(shareItem.snp.bottom).offset(7)
            }
            
            orignalX += (itemWidth + margin)
        }
        
    }
    
    fileprivate lazy var itemDatas: [ShareItem] = {
        var datas = [ShareItem]()
        datas.append(ShareItem("微信", iconName: "share_item_wechat"))
        datas.append(ShareItem("朋友圈", iconName: "share_item_moments"))
        datas.append(ShareItem("复制链接", iconName: "share_item_copy"))
        return datas
    }()
    
    lazy var contentView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: kShareViewHeight, width: kShareViewWidth, height: kContentHeight))
        view.backgroundColor = UIColor.color("#DBDCDC")
        return view
    }()
    
    lazy var cancelBtn: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: kContentHeight - 45, width: kShareViewWidth, height: 45))
        button.setTitleColor(.black, for: .normal)
        button.setTitle("取消", for: .normal)
        button.addTarget(self, action: #selector(onClickCancelButton(_:)), for: .touchUpInside)
        button.backgroundColor = .white
        return button
    }()

    lazy var tapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureAction(_:)))
        return gesture
    }()
}

// MARK: 内部逻辑
extension LSShareView {
    // 分享
    @objc fileprivate func onClickShareItemButton(_ sender: UIButton) {
        APLog(sender.tag)
        
        switch sender.tag - ShareItemDefalutTag {
        case 0:
            shareToWechat()
        case 1:
            shareToMoments()
        case 2:
            copyLinkUrl()
        default:
            break
        }
        
        removeSelf()
    }
    
    @objc fileprivate func onClickCancelButton(_ sender: UIButton) {
        removeSelf()
    }
    
    @objc fileprivate func tapGestureAction(_ gesture: UITapGestureRecognizer) {
        removeSelf()
    }
    
    private func shareToWechat() {
        
        LSWeiXinManager.shared.share(to: WXSceneSession, content: self.shareContent, title: self.shareTitle, description: self.shareDescribe, icon: UIImage(named: "app_icon"))
    }
    
    private func shareToMoments() {
        LSWeiXinManager.shared.share(to: WXSceneTimeline, content: self.shareContent, title: self.shareTitle, description: self.shareDescribe, icon: UIImage(named: "app_icon"))
    }
    
    private func copyLinkUrl() {
        let paste = UIPasteboard.general
        paste.string = self.shareContent
        LSHUD.showText("链接已复制")
    }
    
    // 移除
    private func removeSelf() {
        UIView.animate(withDuration: 0.3, animations: {
            self.backgroundColor = UIColor.color("#000000", alpha: 0.01)
            var rect = self.contentView.frame
            rect.origin.y = kShareViewHeight
            self.contentView.frame = rect
        }) { (success) in
            self.removeFromSuperview()
        }
    }
}

//MARK: -对外接口
extension LSShareView {
    func show(_ content: String, title: String, describe: String) {
        self.shareContent = content
        self.shareTitle = title
        self.shareDescribe = describe
        let rootView = UIApplication.shared.keyWindow?.rootViewController?.view
        rootView?.addSubview(self)
        rootView?.bringSubviewToFront(self)
        
        UIView.animate(withDuration: 0.3) {
            self.backgroundColor = UIColor.color("#000000", alpha: 0.5)
            var rect = self.contentView.frame
            rect.origin.y = kShareViewHeight - kContentHeight
            self.contentView.frame = rect
        }
    }
}

fileprivate struct ShareItem {
    
    var name: String?
    var icon: UIImage?
    
    init(_ name: String?, iconName: String) {
        self.name = name
        self.icon = UIImage(named: iconName)
    }
}
