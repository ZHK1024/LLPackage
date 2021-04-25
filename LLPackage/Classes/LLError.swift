//
//  LLError.swift
//  LLPackage
//
//  Created by ZHK on 2021/4/23.
//  
//

import Foundation

struct LLError: Error {
    
    private let message: String
    
    init(_ message: String) {
        self.message = message
    }
}

extension LLError: ExpressibleByStringLiteral {
    
    typealias StringLiteralType = String
    
    init(stringLiteral value: String) {
        self.message = value
    }
}
