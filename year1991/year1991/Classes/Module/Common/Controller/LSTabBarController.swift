//
//  LSTabBarController.swift
//  year1991
//
//  Created by Lee on 2018/11/19.
//  Copyright © 2018 辛未年. All rights reserved.
//

import UIKit

class LSTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildViewControllers()
        
        NotificationCenter.default.addObserver(self, selector: #selector(onReceiveNotificationRedHotSopt(notify:)), name: LSNotificationName.kTabbarBadge, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension LSTabBarController {
    
    fileprivate func addChildViewControllers() {
        addSingleChildVC(LSFirstViewController(), title: "First", iconName: "tabbar_album_")
        addSingleChildVC(LSSecondViewController(), title: "Second", iconName: "tabbar_feed_")
        addSingleChildVC(LSMineViewController(), title: "Third", iconName: "tabbar_mine_")
    }
    
    private func addSingleChildVC(_ childVC: LSViewController, title: String, iconName: String) {
        let nav = LSNavigationController(rootViewController: childVC)
        childVC.title = title
        childVC.tabBarItem.image = UIImage(named: iconName + "normal")
        childVC.tabBarItem.selectedImage = UIImage(named: iconName + "selected")
        let attriNormal = [NSAttributedString.Key.foregroundColor: UIColor.color("#2C2D32"),NSAttributedString.Key.font: UIFont.font(10)]
        childVC.tabBarItem.setTitleTextAttributes(attriNormal, for: .normal)
        let attriSelected = [NSAttributedString.Key.foregroundColor: UIColor.color("#2C2D32"),NSAttributedString.Key.font: UIFont.font(10)]
        childVC.tabBarItem.setTitleTextAttributes(attriSelected, for: .selected)
        self.addChild(nav)
    }
}

extension LSTabBarController {
    //红点的消息
    @objc fileprivate func onReceiveNotificationRedHotSopt(notify:Notification){
        let dic = notify.object as? Dictionary<String,Any>
        if let dic = dic {
            let show:Bool = dic["show"] as? Bool ?? true
            let index:Int = dic["index"] as? Int ?? 1
            let number: Int = dic["number"] as? Int ?? 0
            let content: String = dic["content"] as? String ?? ""
            if show {
                if number > 0 {
                    self.showBadgOn(index: index, number: number)
                } else if content.count > 0 {
                    self.showBadgOn(index: index, content: content)
                } else {
                    self.showBadgOn(index: index)
                }
            }else{
                self.hideBadg(on: index)
            }
        }
    }
}

//MARK:  红点
fileprivate let kBadgeMaxNumber: Int = 99 // 显示的最大数字
fileprivate let tabbarItemCount: Int = 4 //tabbarItem总数
fileprivate let badgeBackMaxWidth: CGFloat = 50  //badge的最大宽度
fileprivate let badgeBackTag: Int = 666
fileprivate let badgeContentTag: Int = 888

extension LSTabBarController {
    
    /// - 显示小红点
    fileprivate func showBadgOn(index itemIndex: Int) {
        // 移除之前的小红点
        self.removeBadgeOn(index: itemIndex)
        
        // 创建红点背景
        let bageView = UIView()
        bageView.tag = itemIndex + badgeBackTag
        bageView.layer.cornerRadius = 5
        bageView.backgroundColor = UIColor.color("#FF3B30")
        let tabFrame = self.tabBar.frame

        // 确定小红点的位置
        let percentX: CGFloat = (CGFloat(itemIndex) + 0.59) / CGFloat(tabbarItemCount)
        let x: CGFloat = CGFloat(ceilf(Float(percentX * tabFrame.size.width)))
        let y: CGFloat = CGFloat(ceilf(Float(0.115 * tabFrame.size.height)))
        //
        bageView.frame = CGRect(x: x, y: y, width: 10, height: 10)
        self.tabBar.addSubview(bageView)
    }
    
    /// - 显示小红点 数字
    fileprivate func showBadgOn(index itemIndex: Int, number: Int) {
        // 移除之前的小红点
        self.removeBadgeOn(index: itemIndex)
        
        // 创建红点背景
        let bageView = UIView()
        bageView.tag = itemIndex + badgeBackTag
        bageView.layer.cornerRadius = 8
        bageView.backgroundColor = UIColor.color("#FF3B30")
        let tabFrame = self.tabBar.frame
        
        var content = "\(number)"
        if number > kBadgeMaxNumber {
            content = "99+"
        }
        let contentLbl = UILabel()
        contentLbl.tag = itemIndex + badgeContentTag
        contentLbl.font = UIFont.mediumFont(12)
        contentLbl.textColor = UIColor.color("#FFFFFF")
        contentLbl.text = content
        
        // 确定小红点的位置
        let percentX: CGFloat = (CGFloat(itemIndex) + 0.59) / CGFloat(tabbarItemCount)
        let x: CGFloat = CGFloat(ceilf(Float(percentX * tabFrame.size.width)))
        let y: CGFloat = CGFloat(ceilf(Float(0.115 * tabFrame.size.height)))
        let contetWidth = content.width(UIFont.mediumFont(12), maxHeight: 14, maxWidth: badgeBackMaxWidth)
        //
        bageView.frame = CGRect(x: x, y: y, width: contetWidth+10, height: 16)
        contentLbl.frame = CGRect(x: x+5, y: y+1, width: contetWidth, height: 14)
        self.tabBar.addSubview(bageView)
        self.tabBar.addSubview(contentLbl)
    }
    
    /// - 显示小红点 数字
    fileprivate func showBadgOn(index itemIndex: Int, content: String) {
        // 移除之前的小红点
        self.removeBadgeOn(index: itemIndex)
        
        // 创建红点背景
        let bageView = UIView()
        bageView.tag = itemIndex + badgeBackTag
        bageView.layer.cornerRadius = 8
        bageView.backgroundColor = UIColor.color("#FF3B30")
        let tabFrame = self.tabBar.frame
        
        let contentLbl = UILabel()
        contentLbl.tag = itemIndex + badgeContentTag
        contentLbl.font = UIFont.font(10)
        contentLbl.textColor = UIColor.color("#FFFFFF")
        contentLbl.text = content
        
        // 确定小红点的位置
        let percentX: CGFloat = (CGFloat(itemIndex) + 0.59) / CGFloat(tabbarItemCount)
        let x: CGFloat = CGFloat(ceilf(Float(percentX * tabFrame.size.width)))
        let y: CGFloat = CGFloat(ceilf(Float(0.115 * tabFrame.size.height)))
        let contetWidth = content.width(UIFont.font(10), maxHeight: 11, maxWidth: badgeBackMaxWidth)
        //
        bageView.frame = CGRect(x: x, y: y, width: contetWidth+4, height: 16)
        contentLbl.frame = CGRect(x: x+2, y: y+2.5, width: contetWidth, height: 11)
        self.tabBar.addSubview(bageView)
        self.tabBar.addSubview(contentLbl)
    }
    
    // - 隐藏小红点
    fileprivate func hideBadg(on itemIndex: Int) {
        // 移除小红点
        self.removeBadgeOn(index: itemIndex)
    }
    
    // - 移除小红点
    fileprivate func removeBadgeOn(index itemIndex: Int) {
        // 按照tag值进行移除
        _ = tabBar.subviews.map {
            if $0.tag == itemIndex + badgeBackTag {
                $0.removeFromSuperview()
            }
            
            if $0.tag == itemIndex + badgeContentTag {
                $0.removeFromSuperview()
            }
        }
    }
    
}

