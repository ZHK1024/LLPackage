//
//  LLPackageAutoSavable.swift
//  LLPackage
//
//  Created by ZHK on 2021/4/26.
//  
//

import Foundation

#if LLPACK_ZIP_CONTAINS

public protocol LLPackageAutoSavable: LLPackageUnZipable & LLPackageUpdatable {
    
    /// 是否需要解压
    var isNeedUnzip: Bool { get }
}

#else

public protocol LLPackageAutoSavable: LLPackageUpdatable {
    
    /// 是否进行覆盖
    var overwrite: Bool { get }
    
    /// 本地文件存储地址
    var fileURL: URL { get }
}

#endif
 
extension LLPackageAutoSavable {
    #if LLPACK_ZIP_CONTAINS
    public func receive(tempURL: URL, response: URLResponse?) throws {
        if isNeedUnzip {
            try unzip(zipURL: tempURL)
        } else {
            try move(file: tempURL, to: fileURL, overwrite: overwrite)
        }
    }
    #else
    public func receive(tempURL: URL, response: URLResponse?) throws {
        try move(file: tempURL, to: fileURL, overwrite: overwrite)
    }
    #endif
    
    /// 移动文件
    /// - Parameters:
    ///   - file:      目标文件
    ///   - to:        目标位置
    ///   - overwrite: 是否覆盖
    /// - Throws: 错误信息
    public func move(file: URL, to: URL, overwrite: Bool) throws {
        if FileManager.default.fileExists(atPath: to.path) {
            if overwrite == false {
                throw "文件已存在" as LLError
            }
            _ = try FileManager.default.replaceItemAt(to, withItemAt: file)
        } else {
            try FileManager.default.moveItem(at: file, to: to)
        }
    }
}
