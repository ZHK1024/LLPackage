//
//  LLPackage.swift
//  LLPackage
//
//  Created by ZHK on 04/23/2021.
//  Copyright (c) 2021 ruris. All rights reserved.
//

public struct LLPackage {
    
    public typealias Complete = (Bool, Error?) -> Void
    
    static public func sync<T: LLPackageUpdatable>(package: T.Type, complete: @escaping Complete) {
        package.check().then {
            switch $0 {
            case .fulfilled(let need):
                if need {
                    package.download(complete: complete)
                } else {
                    complete(true, nil)
                }
            case .rejected(let error):
                complete(false, error)
            }
        }
    }
}
