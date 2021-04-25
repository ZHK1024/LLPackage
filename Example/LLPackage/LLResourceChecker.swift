//
//  LLResourceChecker.swift
//  LLPackage_Example
//
//  Created by ZHK on 2021/4/25.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import LLPackage

struct LLResourceChecker: LLPackageCheckable {
    
    typealias T = Result
    
    static var request: URLRequest {
        URLRequest(url: URL(string: "http:/192.168.3.210:8080/resource")!)
    }
    
    static func response1(data: Result) {
        
    }
}


extension LLResourceChecker {
    
    struct Result: Decodable {
        
        let data: [Resource]
    }
    
    struct Resource: Decodable {
        
        let version: Int
        
        let url: String
    }
}
