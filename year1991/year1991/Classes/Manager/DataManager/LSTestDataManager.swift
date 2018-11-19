//
//  LSTestDataManager.swift
//  year1991
//
//  Created by Lee on 2018/11/19.
//  Copyright © 2018 辛未年. All rights reserved.
//
//  测试数据

import UIKit

let kTestPlaceholderImageUrl = "https://i.loli.net/2017/11/09/5a046546a2a1f.jpg"

class LSTestDataManager: NSObject {
    
    static let shared = LSTestDataManager()
    
    private override init() {
        super.init()
    }
    
    private let nicks = ["tangwei","汤唯","高圆圆","南山吗，恩嘎开发","张三理发离开","里斯","李四","王二","王麻子","王麻子的名字很长哼唱很长哼唱","李四也有一个长名字","Sam","Sam Lee"]
    private let uids = ["ap_activity_album_uid_000001","ap_activity_album_uid_000002","ap_activity_album_uid_000003","ap_activity_album_uid_000004","ap_activity_album_uid_000005","ap_activity_album_uid_000006","ap_activity_album_uid_000007","ap_activity_album_uid_000008","ap_activity_album_uid_000009","ap_activity_album_uid_000000","ap_activity_album_uid_000000","ap_activity_album_uid_000000"]
    private let names = ["社交产品共创群","西湖宝宝圈","老司机带飞群","同窗之旅","Welcome to my party!","尼古拉斯赵四","王者归来北京大饭店北京大饭店北京大饭店","北京大饭店撕拉法华经的高科技感觉"]
    private let times = ["星期五","14:24","13:46","13:31","12:25"]
//    2018-09-29 10:30:11
    private let dates = ["2017.02.20 19:20","2018.10.20 12:20","2018.11.22 12:20","2018.11.02 12:20","2015.10.20 10:20"]
    private let imgUrls = ["https://i.loli.net/2017/11/09/5a046546a2a1f.jpg","http://imgcdn.xiaoxigeek.com/FpLvKg1ewTAWKEoj9j0K_9io0kNq","http://imgcdn.xiaoxigeek.com/FotMh1lKTpz1WLzPJbdifYWwdeI4","http://imgcdn.xiaoxigeek.com/Fixe8y0gdmjhPZuHObBzqiqi5hcu","https://i.loli.net/2017/11/09/5a046546a2a1f.jpg"]
    
    var nick:String {
        return nicks[Int(arc4random_uniform(UInt32(nicks.count)))]
    }
    
    var name:String {
        return names[Int(arc4random_uniform(UInt32(names.count)))]
    }
    
    var uid:String {
        return uids[Int(arc4random_uniform(UInt32(uids.count)))]
    }
    
    var time:String {
        return times[Int(arc4random_uniform(UInt32(times.count)))]
    }
    
    var date: String {
        return dates[Int(arc4random_uniform(UInt32(dates.count)))]
    }
    
    var randomStr: String {
        return randomStr(len: Int(arc4random_uniform(100)))
    }
    
    var imageUrl: String {
        return imgUrls[Int(arc4random_uniform(UInt32(imgUrls.count)))]
    }
    
    var coverUrl: URL? {
        return URL(string: LSTestDataManager.shared.imageUrl)
    }
    
    private let random_str_characters = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ开发好风景啊就分开了发号施令是开挂了第九十六回事记得给老公链家时光，。！；辣椒不撒娇啊飞就到了发福利"
    /// 随机字符串
    func randomStr(len : Int) -> String{
        var ranStr = ""
        for _ in 0..<len {
            let index = Int(arc4random_uniform(UInt32(random_str_characters.count)))
            ranStr.append(random_str_characters[random_str_characters.index(random_str_characters.startIndex, offsetBy: index)])
        }
        return ranStr
    }
    

}
