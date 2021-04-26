//
//  LLPackageUpdatable.swift
//  LLPackage
//
//  Created by ZHK on 2021/4/23.
//  
//

import Foundation

/// 资源包信息模板
/// 可以根据 `LLPackageUpdatable` 自定义符合自己项目需求的资源包信息类型
public protocol LLPackageUpdatable {
    
    /// 资源包请求对象
    var request: URLRequest { get }
    
    /// 是否需要更新
    var isNeedUpdate: Bool { get }
    
    /// 资源文件下载完成, 在此处进行覆盖等操作
    /// - Parameters:
    ///   - tempURL:  下载文件临时存放地址
    ///   - response: 请求响应对象
    func receive(tempURL: URL, response: URLResponse?) throws
    
    /// 更新完成
    func packageUpdateDidFinished()
}

extension LLPackageUpdatable {
    
    /// 下载资源包
    /// - Parameter complete: 下载结果回调
    public func download(complete: @escaping LLPackage.Complete) {
        URLSession.shared.downloadTask(with: request) { (url, response, aerror) in
            if let tempURL = url {
                do {
                    try receive(tempURL: tempURL.absoluteURL, response: response)
                    packageUpdateDidFinished()
                } catch {
                    complete(false, error)
                }
            } else {
                complete(url == nil, aerror ?? "未知错误" as LLError)
            }
        }.resume()
    }
}
