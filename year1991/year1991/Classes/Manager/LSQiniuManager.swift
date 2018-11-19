//
//  LSQiniuManager.swift
//  year1991
//
//  Created by Lee on 2018/11/19.
//  Copyright © 2018 辛未年. All rights reserved.
//

import UIKit
import Qiniu

class LSQiniuManager: NSObject {

    static let shared = LSQiniuManager()
    
    private let uploadManager = QNUploadManager()
//    private let qiniuAuth = VVCoreDataManager.shareInstance.getQiniuAuthImage() ?? QiniuAuthBody()
    
    private override init() {
        super.init()
    }
    
    
    /// 上传图片到七牛
    ///
    /// - Parameters:
    ///   - image: 需要上传的图片
    ///   - result: 上传结果
    func upload(image:UIImage, result:@escaping(_ success:Bool,_ imageUrl:String?) -> ()) {
        
        let data = image.jpegData(compressionQuality: 1)
        guard let imgData = data else {
            result(false,nil)
            return
        }
//            UIImageJPEGRepresentation(image, 1)!
        let qnKey = QNEtag.data(imgData)
        
        /**
         *    上传完成后的回调函数
         *
         *    @param info 上下文信息，包括状态码，错误值
         *    @param key  上传时指定的key，原样返回
         *    @param resp 上传成功会返回文件信息，失败为nil; 可以通过此值是否为nil 判断上传结果
         */
        //TODO: token
        uploadManager?.put(imgData, key: qnKey, token: "qiniuAuth.upload_token", complete: { (info, key, resp) in
            APLog("qiniu upload image comlete:\(String(describing: info))")
            
            if resp == nil {
                result(false, nil)
                return
            }
            
            let imgName:String? = resp!["imgUrl"] as? String
            
            if imgName == nil{
                result(false, nil)
            }else{
                //成功
                //                let imgUrl:String = String(format:"%@%@",(self.qiniuAuth.domain_name),imgName!)
                result(true, imgName)
            }
            
        }, option: nil)
        
    }
    
    /// 上传音频文件
    ///
    /// - Parameters:
    ///   - path: 文件路径
    func upload(audio path:String,  result:@escaping(_ success:Bool,_ imageUrl:String?) -> ()) {
        
        let audioData = NSData(contentsOfFile: path) as Data?
        guard let data = audioData else {
            APLog("音频数据有误")
            result(false,nil)
            return
        }
        let qnKey = QNEtag.data(data)
        
        /**
         *    上传完成后的回调函数
         *
         *    @param info 上下文信息，包括状态码，错误值
         *    @param key  上传时指定的key，原样返回
         *    @param resp 上传成功会返回文件信息，失败为nil; 可以通过此值是否为nil 判断上传结果
         */
        //TODO: token
        uploadManager?.put(data, key: qnKey, token: "qiniuAuth.upload_token", complete: { (info, key, resp) in
            APLog("qiniu upload image comlete:\(String(describing: info))")
            
            if resp == nil {
                result(false, nil)
                return
            }
            
            let imgName:String? = resp!["imgUrl"] as? String
            
            if imgName == nil{
                result(false, nil)
            }else{
                //成功
                //                let imgUrl:String = String(format:"%@%@",(self.qiniuAuth.domain_name),imgName!)
                result(true, imgName)
            }
            
        }, option: nil)
        
    }
    
}
