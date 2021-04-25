//
//  LLPackageChecker.swift
//  LLPackage
//
//  Created by ZHK on 2021/4/25.
//  
//

import Foundation

struct LLPackageChecker<S: Decodable>: LLPackageCheckable {
    
    typealias T = S
    
    static var request: URLRequest {
        URLRequest(url: URL(string: "")!)
    }

    static func response1(data: S) {
        
    }
}
