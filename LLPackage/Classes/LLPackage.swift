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
//        if package.check() == false { return }
        package.check().then {
            switch $0 {
            case .fulfilled(let need):
                if need {
                    package.download(complete: complete)
                }
            case .rejected(let error):
                complete(false, error)
            }
        }
        
    }
}

extension LLPackage {
    
    struct A {
        
        func checkThen<T: LLPackageUpdatable>(block: () -> [T.Type]) -> B {
            return B()
        }
    }
    
    struct B {
        
        @discardableResult
        func then(block: () -> Void) -> B {
            return B()
        }
    }
    
    static func sy<T: LLPackageCheckable>(block: () -> T.Type) -> A {
        return A()
    }
    
    static func sad() {
        LLPackage.sy {
            ABC.self
        }.checkThen {
            [DBD.self]
        }.then {
            
        }
    }
    
    struct ABC: LLPackageCheckable {
        
        typealias T = [String:Int]
        
        static var request: URLRequest { URLRequest(url: URL(string: "")!) }
        
        static func response1(data: [String : Int]) {
           Character
        }
    }
    
    struct DBD: LLPackageUpdatable {
        static var request: URLRequest { URLRequest(url: URL(string: "")!) }
        
        static func check() -> LLPromise<Bool> {
            LLPromise<Bool>()
        }
        
        static func replace(tempURL: URL, response: URLResponse?) {
            
        }
    }
}
