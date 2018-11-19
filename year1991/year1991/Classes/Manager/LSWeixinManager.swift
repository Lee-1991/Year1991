//
//  LSWeixinManager.swift
//  year1991
//
//  Created by Lee on 2018/11/19.
//  Copyright © 2018 辛未年. All rights reserved.
//

import UIKit


protocol LSWeixinManagerDelegate {
    func weixinLogin(code: String)
}

class LSWeiXinManager: NSObject {
    
    static let id = "wx5e91ceab89e5e9bf"
    
    static let shared = LSWeiXinManager()
    private override init() {
        super.init()
    }
    
    var delegate: LSWeixinManagerDelegate?
    
    /// 注册应用
    @discardableResult
    func registerApp(_ appid: String) -> Bool {
        let result = WXApi.registerApp(appid)
        return result
    }
    
    /// 登录
    func loginWithWeixin(_ delegate: LSWeixinManagerDelegate) {
        
        // 这个判断有问题，不加这个判断
        guard WXApi.isWXAppInstalled() else {
            LSHUD.showInfo("微信登录不可用")
            return
        }
        
        self.delegate = delegate
        let req = SendAuthReq()
        req.scope = "snsapi_userinfo"
        req.state = "iOS_App"
        WXApi.send(req)
    }
    
    //TODO: 修改图片之类的测试数据
    ///  分享
    func share(to scene: WXScene,content: String, title: String, description: String, icon: UIImage?) {
        guard WXApi.isWXAppInstalled() else {
            LSHUD.showInfo("微信分享不可用")
            return
        }
        let req = SendMessageToWXReq()
        req.bText = false
        req.scene = Int32(scene.rawValue)
        let message = WXMediaMessage()
        message.title = title
        message.description = description
        message.setThumbImage(icon)
        let obj = WXWebpageObject()
        obj.webpageUrl = content
        
        message.mediaObject = obj
        req.message = message
        
        WXApi.send(req)
    }
    
    /// 回调处理
    func handleOpenUrl(_ url: URL) -> Bool {
        return WXApi.handleOpen(url, delegate: self)
    }
    
}

extension LSWeiXinManager: WXApiDelegate {
    
    func onResp(_ resp: BaseResp!) {
        
        if let authResp = resp as? SendAuthResp {
            /// 授权回调
            if authResp.errCode == 0 {
                APLog(resp.description)
                APLog(authResp.code)
                delegate?.weixinLogin(code: authResp.code)
            } else {
                APLog( "微信登录错误\(resp.errCode):" + resp.errStr)
            }
        } else if let sendResp = resp as? SendMessageToWXResp {
            // 分享回调
            if sendResp.errCode == 0 {
                //                APHUD.showSuccess("分享成功")
            } else {
                LSHUD.showError("分享失败")
            }
        }
        
    }
}
