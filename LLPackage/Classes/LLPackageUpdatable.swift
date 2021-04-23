//
//  LLPackageUpdatable.swift
//  LLPackage
//
//  Created by ZHK on 2021/4/23.
//  
//

import Foundation

public protocol LLPackageUpdatable {
    
    /// 资源包请求对象
    static var request: URLRequest { get }
    
    static func check() -> LLPromise<Bool>
    
    /// 资源文件下载完成, 在此处进行覆盖等操作
    /// - Parameters:
    ///   - tempURL:  下载文件临时存放地址
    ///   - response: 请求响应对象
    static func replace(tempURL: URL, response: URLResponse?)
}

extension LLPackageUpdatable {
    
    /// 下载资源包
    /// - Parameter complete: 请求回调
    public static func download(complete: @escaping LLPackage.Complete) {
        URLSession.shared.downloadTask(with: request) { (url, response, aerror) in
            if let tempURL = url {
                replace(tempURL: tempURL, response: response)
            }
            complete(url == nil, aerror ?? "未知错误" as LLError)
        }.resume()
    }
}
