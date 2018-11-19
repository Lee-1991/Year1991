//
//  LSAuthority.swift
//  year1991
//
//  Created by Lee on 2018/11/19.
//  Copyright © 2018 辛未年. All rights reserved.
//

import UIKit
import AVKit
import Photos

class LSAuthority: NSObject {
    static private let appName = "活动相册"
    
    /// 麦克风
    static func authorizeMicrophone() -> Bool{
        let mediaType = AVMediaType.audio
        let authorizationStatus = AVCaptureDevice.authorizationStatus(for: mediaType)
        switch authorizationStatus {
        case .notDetermined:  //用户尚未做出选择
            AVCaptureDevice.requestAccess(for: .audio) { (result) in
                APLog("获取麦克风权限：\(result)")
            }
            return false
        case .authorized:  //已授权
            return true
        case .denied:  //用户拒绝
            LSAuthority.openSetting("请在iPhone的“设置-隐私”选项中，允许\(LSAuthority.appName)使用你的麦克风")
            return false
        case .restricted:  //家长控制
            return false
        }
    }
    
    /// 相册访问权限
    static func authorizePhotoLibrary() -> Bool {
        
        let authorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch authorizationStatus {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({ (status) in
            })
            return false
        case .authorized:
            return true
        case .restricted:
            LSHUD.showInfo("相册访问受限！")
            return false
        case .denied:
            LSAuthority.openSetting("请在iPhone的“设置-隐私”选项中，允许\(LSAuthority.appName)访问你的相册")
            return false
        }
    }
    
    /// 相机权限
    static func authorizeCamera()->Bool{
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch status {
        case .notDetermined:
            // 请求授权
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (sucess) in
                
            })
            return false
        case .authorized:
            return true
        case .restricted:
            LSHUD.showInfo("相机访问受限！")
            return false
        case .denied:
            LSAuthority.openSetting("请在iPhone的“设置-隐私”选项中，允许\(LSAuthority.appName)访问你的相机")
            return false
        }
    }
    
    static private func openSetting(_ tips: String) {
        let alertController = UIAlertController(title: "提示", message: tips, preferredStyle: .alert)
        let openUrl = UIAlertAction(title: "设置", style: UIAlertAction.Style.default) { (alertAction) -> Void in
            if #available(iOS 10.0, *) {
                if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(appSettings)
                    
                    //                    UIApplication.shared.openURL(appSettings)
                }
            }
        }
        alertController.addAction(openUrl)
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(cancel)
        UIViewController.current()?.present(alertController, animated: true, completion: nil)
    }
}
