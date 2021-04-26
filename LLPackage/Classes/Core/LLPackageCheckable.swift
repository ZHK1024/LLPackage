//
//  LLPackageCheckable.swift
//  LLPackage
//
//  Created by ZHK on 2021/4/23.
//  
//

import Foundation

/// LLPackageCheckable 规定了 Checker (资源包版本检查器) 的功能模板
/// 可以根据 LLPackageCheckable 自定义符合自己需求的版本检查器
public protocol LLPackageCheckable {

    /// API 接口返回的数据类型
    associatedtype T: Decodable
    
    /// 网络请求对象
    var request: URLRequest { get }
}

extension LLPackageCheckable {
    
    /// 网络请求
    /// - Parameter complete: 请求结果
    func network(complete: @escaping (T?, Error?) -> Void) {
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let jsonData = data else {
                complete(nil, error ?? "未知错误" as LLError)
                return
            }
            do {
                complete(try JSONDecoder().decode(T.self, from: jsonData), nil)
            } catch {
                complete(nil, LLError("\(T.self): " + error.localizedDescription))
            }
        }.resume()
    }
}
