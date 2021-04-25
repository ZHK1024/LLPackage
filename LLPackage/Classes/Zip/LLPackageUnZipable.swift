//
//  LLPackageUnZipable.swift
//  LLPackage
//
//  Created by ZHK on 2021/4/25.
//  
//

import Foundation
import SSZipArchive

extension LLPackageUpdatable {
    
    static func unzip(url: URL) throws {
        if FileManager.default.fileExists(atPath: url.path) {
            throw "下载文件不存在" as LLError
        }
//        url.deletingLastPathComponent().path + "/\(cfabs)"
        SSZipArchive.unzipFile(atPath: url.path, toDestination: "")
    }
}
