//
//  LSNetwork.swift
//  year1991
//
//  Created by Lee on 2018/11/19.
//  Copyright © 2018 辛未年. All rights reserved.
//


import UIKit
import Alamofire
import SwiftyJSON

/// 输出日志
///
/// - parameter message:  日志消息
/// - parameter file:     文件名
/// - parameter method:   方法名
/// - parameter line:     代码行数
fileprivate func NetLog<T>(message: T?,
                           file: String = #file,
                           method: String = #function,
                           line: Int = #line)
{
    #if DEBUG
    print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(String(describing:  message))")
    #endif
}

/// 服务器域名：正式环境
fileprivate let kServerHostFormal = "http://188.131.131.229:8080"
/// 服务器域名：测试环境
fileprivate let kServerHostTest = "https://test-api.dustess.com"


class LSNetwork: NSObject {
    
    enum ResultCode: Int {
        /// 成功
        case success = 0
        /// token过期
        case token_expired = 2
        /// 本地网络错误
        case local_error = -100
    }
    
    static let shared = LSNetwork()
    
    private override init() {
        super.init()
        
    }

    /// 服务器地址
    private var hostAddress: String {
        if APConfig.serverEnvironmentFormal() {
            return kServerHostFormal
        }else{
            return kServerHostTest
        }
    }

    /// 请求头http header
    private var httpHeader: HTTPHeaders {
        // let iosVersion : NSString = UIDevice.currentDevice().systemVersion
        let version:String = Bundle.main.infoDictionary!["CFBundleVersion"] as! String
        //UIDevice.current.systemVersion
        let deviceUUID:String! =  UIDevice.current.identifierForVendor?.uuidString
        var header = HTTPHeaders()
        header["platform"] = NSNumber(value: 2).stringValue
        header["version"] = String(format: "%@",version)
        header["imei"] = deviceUUID
        header["channel"] = "AppStore"
        header["Authorization"] = AppEngin.shared.token
        header["Content-Type"] = "application/json"
        return header
    }

}

// MARK: 接口
extension LSNetwork {
    /// http的get请求
    func httpGetRequest(path:String,para:Dictionary<String,Any>?, response:  @escaping (JSON)->()){
        
        let url = getRequestUrl(path)
        
        NetLog(message: url)
        Alamofire.request(url, method: .get, parameters: para, encoding: URLEncoding.default, headers: httpHeader).responseJSON { (result) in
            
            switch result.result {
            case .success(let value):
                let jsonSwift = JSON(value)
                self.handleResponseResult(json: jsonSwift)
                response(jsonSwift)
                NetLog(message: "url:\(url)")
                NetLog(message: "JSON: \(jsonSwift)")
                
            case .failure(let error):
                NetLog(message: error)
                let json:JSON = ["err":-100,"msg":"请求失败"]
                response(json)
                NetLog(message: "url:\(url)")
                NetLog(message: "JSON: \(json)")
            }
            
        }
    }
    
    /// http的put请求
    func httpPutRequest(path:String,para:Dictionary<String,Any>?, response:  @escaping (JSON)->()){
        
        let url = getRequestUrl(path)
        
        Alamofire.request(url, method: .put, parameters: para, encoding: JSONEncoding.default, headers: httpHeader).responseJSON { (result) in
            
            switch result.result {
            case .success(let value):
                let jsonSwift = JSON(value)
                self.handleResponseResult(json: jsonSwift)
                response(jsonSwift)
                NetLog(message: "url:\(url)")
                NetLog(message: "JSON: \(jsonSwift)")
                
            case .failure(let error):
                NetLog(message: error)
                let json:JSON = ["err":-100,"msg":"请求失败"]
                response(json)
                NetLog(message: "url:\(url)")
                NetLog(message: "JSON: \(json)")
            }
            
        }
    }
    
    /// http的post请求
    @discardableResult
    func httpPostRequest(path:String,para:Dictionary<String,Any>?, response:  @escaping (JSON)->()) -> DataRequest{
        
        let url = getRequestUrl(path)
        
        let request = Alamofire.request(url, method: .post, parameters: para, encoding: JSONEncoding.default, headers: httpHeader).responseJSON { (result) in
            
            switch result.result {
            case .success(let value):
                let jsonSwift = JSON(value)
                self.handleResponseResult(json: jsonSwift)
                response(jsonSwift)
                NetLog(message: "url:\(url)")
                NetLog(message: "JSON: \(jsonSwift)")
                
            case .failure(let error):
                NetLog(message: error)
                if let data = result.data {
                    let str = String(data: data, encoding: String.Encoding.utf8)
                    APLog(str)
                }
                
                let json:JSON = ["err":-100,"msg":"请求失败"]
                response(json)
                NetLog(message: "url:\(url)")
                NetLog(message: "JSON: \(json)")
            }
            
        }
        
        return request
    }
    
    // http的delete请求
    func httpDeleteRequest(path:String,para:Dictionary<String,Any>?, response:  @escaping (JSON)->()){
        
        let url = getRequestUrl(path)
        //TODO: delete 请求的参数放在body中的情况
        Alamofire.request(url, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: httpHeader).responseJSON { (result) in
            
            switch result.result {
            case .success(let value):
                let jsonSwift = JSON(value)
                self.handleResponseResult(json: jsonSwift)
                response(jsonSwift)
                NetLog(message: "url:\(url)")
                NetLog(message: "JSON: \(jsonSwift)")
            case .failure(let error):
                NetLog(message: error)
                let json:JSON = ["err":-100,"msg":"请求失败"]
                response(json)
                NetLog(message: "url:\(url)")
                NetLog(message: "JSON: \(json)")
            }
            
        }
    }
}

extension LSNetwork {
    
    fileprivate func getRequestUrl(_ path: String) -> String {
        let url = hostAddress + path
//        url = url.addingPercentEncoding(withAllowedCharacters: )
        return url
    }
    
    fileprivate func handleResponseResult(json:JSON){
        let code = ResultCode(rawValue: json["err"].intValue)
        if code == ResultCode.token_expired {
//        登录失效的统一处理
        }
        
    }
    
    //字典转json字符串
    func toJSONString(dict:Dictionary<String, Any>?)->String{
        
        if let dict = dict {
            let data = try? JSONSerialization.data(withJSONObject: dict)
            
            let strJson = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            
            return strJson! as String
        }else{
            return ""
        }
    }

}
