//
//  LLPackageUnZipable.swift
//  LLPackage
//
//  Created by ZHK on 2021/4/25.
//  
//

import Foundation
import SSZipArchive

/// ZIP 解压相关
public protocol LLPackageUnZipable {
    
    /// 是否进行覆盖
    var overwrite: Bool { get }
    
    /// 本地文件存储地址
    var fileURL: URL { get }
    
    /// 压缩文件密码
    var password: String? { get }
}

extension LLPackageUnZipable {
    
    /// 解压文件到指定路径
    /// - Parameter zipURL: ZIP 文档路径
    /// - Throws: 异常信息
    public func unzip(zipURL: URL) throws {
        if FileManager.default.fileExists(atPath: zipURL.path) == false {
            throw "下载文件不存在" as LLError
        }
        try SSZipArchive.unzipFile(atPath: zipURL.path, toDestination: fileURL.path, overwrite: overwrite, password: password)
    }
}
