//
//  LLPromise.swift
//  LLPackage_Example
//
//  Created by ZHK on 2021/4/23.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation

public class LLPromise<T> {
    
    public typealias Block = (Result) -> Void
    
    private var block: Block?
    
    private var holder: LLPromise<T>?
    
    public init() {
        holder = self
    }
    
    func dispose() {
        holder = nil
    }
    
    public func then(_ complete: @escaping Block) {
        block = complete
        dispose()
    }
    
    public func fulfill(value: T) {
        block?(.fulfilled(value))
    }
    
    public func reject(_ error: Error) {
        block?(.rejected(error))
    }
    
    public enum Result {
        case fulfilled(T)
        case rejected(Error)
    }
}
