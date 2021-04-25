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
    
    public class Check {
        
        public typealias Block = (LLResult) -> [LLPackageUpdatable.Type]
        
        fileprivate var block: Block?
        
//        public func checkThen<T: LLPackageUpdatable>(block: (LLResult) -> [T.Type]) -> Then {
//            return Then()
//        }
        
        fileprivate let then = Then()
        
        public func checkThen(block: @escaping Block) -> Then {
//            let then = Then()
            self.block = block
            return then
        }
    }
    
    public class Then {
        
        fileprivate var block: ((Bool, Error) -> Void)?
        
//        @discardableResult
        public func then(block: @escaping (Bool, Error) -> Void) {
//            return Then()
            self.block = block
        }
    }
    
    public typealias LLResult = Result<Decodable, Error>
    
    static func sy<T: LLPackageCheckable>(block: () -> T.Type) -> Check {
        let check = Check()
        block().network {
            if let result = $0 {
                check.block?(LLResult.success(result)).forEach { $0.download { (success, error) in
//                    check.then.block?($0, $1)
                } }
            } else {
                _ = check.block?(LLResult.failure($1 ?? "" as LLError))
            }
        }
        return check
    }
    
    static public func sync<C: LLPackageCheckable, U: LLPackageUpdatable>(_ check: C.Type, packages: @escaping (C.T) -> [U.Type], complete: @escaping (UpdateResult) -> Void) {
        check.network {
            if let result = $0 {
                let a = UpdateResult()
                let pkgs = packages(result)
                pkgs.forEach { resource in
                    resource.download { (success, error) in
                        objc_sync_enter(a)
                        if success {
                            a.success.append(resource)
                        } else {
                            a.failure.append(resource)
                            a.errors[resource.request.url!.absoluteString] = error
                        }
                        if a.success.count + a.failure.count == pkgs.count {
                            complete(a)
                        }
                        objc_sync_exit(a)
                    }
                }
            } else {
//                complete(false, $1)
                print($1)
            }
        }
    }
    
    public class UpdateResult {
        
        var success: [LLPackageUpdatable.Type] = []
        
        var failure: [LLPackageUpdatable.Type] = []
        
        fileprivate var errors: [String : Error] = [:]
        
        
    }
    
    static func sad() {
//        LLPackage.sy {
//            ABC.self
//        }.checkThen { (a) -> [LLPackageUpdatable.Type] in
//            [DBD.self]
//        }.then {
//
//        }
    }
    
    struct ABC: LLPackageCheckable {
        
        typealias T = [String:Int]
        
        static var request: URLRequest { URLRequest(url: URL(string: "")!) }
        
        static func response1(data: [String : Int]) {
//           Character
        }
    }
    
    struct DBD: LLPackageUpdatable {
        static var overwrite: Bool = false
        
        
        static var isZip: Bool = false
        
        static var request: URLRequest { URLRequest(url: URL(string: "")!) }
        
        static func check() -> LLPromise<Bool> {
            LLPromise<Bool>()
        }
        
        static func replace(tempURL: URL, response: URLResponse?) {
            
        }
    }
}
