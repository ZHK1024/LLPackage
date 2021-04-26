//
//  LLPackage.swift
//  LLPackage
//
//  Created by ZHK on 04/23/2021.
//  Copyright (c) 2021 ruris. All rights reserved.
//

public struct LLPackage {
    
    public typealias Complete = (Bool, Error?) -> Void
    
    public typealias LLResult = Result<UpdateResult, Error>
    
    /// 同步资源包
    /// - Parameters:
    ///   - checker:  检查器, 检查资源包版本
    ///   - packages: 资源包信息对象
    ///   - complete: 同步结果回调
    static public func sync<C: LLPackageCheckable, U: LLPackageUpdatable>(_ checker: C, packages: @escaping (C.T) -> [U], complete: @escaping (LLResult) -> Void) {
        checker.network { (res, error) in
            DispatchQueue.main.async {
                if let result = res {
                    downloadPackages(packages: packages(result)) { complete($0) }
                } else {
                    complete(LLResult.failure(error ?? "未知错误" as LLError))
                }
            }
        }
    }
}

extension LLPackage {
    
    /// 执行下载任务, 下载资源包
    /// - Parameters:
    ///   - packages: 下载任务对象
    ///   - complete: 任务结果回调
    static func downloadPackages<P: LLPackageUpdatable>(packages: [P], complete: @escaping (LLResult) -> Void) {
        let result = UpdateResult()
        packages.forEach { package in
            /// 需要更新的才进行更新
            /// 不需要更新的直接插入 `成功` 列表
            if package.isNeedUpdate {
                package.download { (success, error) in
                    objc_sync_enter(result)
                    if success {
                        result.success.append(package)
                    } else {
                        result.failure.append(package)
                        result.errors[package.request.url!.absoluteString] = error
                    }
                    /// 下载任务全部完成之后, 进行回调
                    /// 下载任务全部完成条件: `任务完成数量` + `任务失败数量` == `任务总数量`
                    if result.success.count + result.failure.count == packages.count {
                        complete(LLResult.success(result))
                    }
                    objc_sync_exit(result)
                }
            } else {
                objc_sync_enter(result)
                result.success.append(package)
                if result.success.count + result.failure.count == packages.count {
                    complete(LLResult.success(result))
                }
                objc_sync_exit(result)
            }
        }
    }
    
    public class UpdateResult {
        
        /// 下载成功列表
        public var success: [LLPackageUpdatable] = []
        
        /// 下载失败列表
        public var failure: [LLPackageUpdatable] = []
        
        /// 错误列表
        fileprivate var errors: [String : Error] = [:]

        /// 根据失败任务获取错误信息
        /// - Parameter package: 任务对象
        /// - Returns: 错误信息
        public func error<P: LLPackageCheckable>(with package: P) -> Error? {
            guard let url = package.request.url?.absoluteString else {
                return nil
            }
            return errors[url]
        }
    }
}
