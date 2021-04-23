//
//  LLPackageCheckable.swift
//  LLPackage
//
//  Created by ZHK on 2021/4/23.
//  
//

import Foundation

public protocol LLPackageCheckable {
    
    associatedtype T: Decodable
    
//    typealias CheckResult = (Self.T?, Error?)
    
    static var request: URLRequest { get }
    
    static func response1(data: T)
}

extension LLPackageCheckable {
    
    static func network(complete: @escaping (T?, Error?) -> Void) {
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let jsonData = data else {
                complete(nil, error ?? "未知错误" as LLError)
                return
            }
            do {
                response1(data: try JSONDecoder().decode(T.self, from: jsonData))
            } catch {
                complete(nil, error)
            }
        }.resume()
    }
}
