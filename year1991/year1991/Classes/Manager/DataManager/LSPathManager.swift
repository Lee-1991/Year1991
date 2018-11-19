//
//  LSPathManager.swift
//  year1991
//
//  Created by Lee on 2018/11/19.
//  Copyright © 2018 辛未年. All rights reserved.
//

import UIKit

class LSPathManager: NSObject {

    // MARK: - return document
    /// document下面的路径
    ///
    /// - Parameter fileName: 文件名
    static func documentsFilePath(_ fileName: String) -> String {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first! as String
        let filePath = (path as NSString).appendingPathComponent(fileName)
        return filePath
    }
    
    /// document下面的路径
    ///
    /// - Parameter fileName: 文件名
    /// - Returns: URL路径
    static func documentsFileUrl(_ fileName: String) -> URL {
        let url = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent(fileName)
        return url
    }

}
