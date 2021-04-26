//
//  LLPackageChecker.swift
//  LLPackage
//
//  Created by ZHK on 2021/4/25.
//  
//

import Foundation


public struct LLPackageChecker<S: Decodable>: LLPackageCheckable {

    public typealias T = S
    
    public typealias R = S
    
    public var request: URLRequest
    
    public init(request: URLRequest) {
        self.request = request
    }
}
