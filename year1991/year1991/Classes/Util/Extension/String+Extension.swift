//
//  String+Extension.swift
//  year1991
//
//  Created by Lee on 2018/11/19.
//  Copyright © 2018 辛未年. All rights reserved.
//

import UIKit


extension String {
    /// 将字符串md5处理
    var md5 : String{
        let strEncoding = self.cString(using: String.Encoding.utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        guard let str = strEncoding else {
            assert(strEncoding != nil, "字符串md5过程出现为空现象")
            return self
        }
        CC_MD5(str, strLen, result)
        
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        //result.deinitialize() //这个方法过期了，从网上找的新方法free(result)
        free(result)
        return String(format: hash as String)
    }
    
    /// 计算文本长度，中文只算两个字符
    func lengthOfBytesInChinise() -> Int{
        var length = 0
        for char in self {
            length += "\(char)".lengthOfBytes(using: String.Encoding.utf8) == 3 ? 2:1
        }
        return length
    }
    
    /// 根据字符获取宽度
    func width(_ font: UIFont, maxHeight: CGFloat, maxWidth: CGFloat = kScreenWidth) -> CGFloat {
        let tempStr = self as NSString
        return tempStr.boundingRect(with: CGSize.init(width: maxWidth, height: maxHeight), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : font], context: nil).size.width
    }
    
    /// 根据字符获取高度
    func height(_ font: UIFont, maxWith: CGFloat) -> CGFloat {
        let tempStr = self as NSString
        return tempStr.boundingRect(with: CGSize.init(width: maxWith, height: 10000), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : font], context: nil).size.height
    }
    
//    /// 根据字符获取高度
//    func height(_ font: UIFont, maxWidth: CGFloat = kScreenWidth) ->CGFloat {
//        let size = CGSize(width: maxWidth, height: 0)
//        let attribute = [NSAttributedStringKey.font: font]
//        let option: NSStringDrawingOptions = .usesLineFragmentOrigin
//        let strRect = (self as NSString).boundingRect(with: size, options: option, attributes: attribute, context: nil)
//        return strRect.height
//    }
    
    /// 随机字符串
    static func randomStr(len : Int) -> String{
        let random_str_characters = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ开发好风景啊就分开了发号施令是开挂了第九十六回事记得给老公链家时光，。！；辣椒不撒娇啊飞就到了发福利"
        var ranStr = ""
        for _ in 0..<len {
            let index = Int(arc4random_uniform(UInt32(random_str_characters.count)))
            ranStr.append(random_str_characters[random_str_characters.index(random_str_characters.startIndex, offsetBy: index)])
        }
        return ranStr
    }

}
