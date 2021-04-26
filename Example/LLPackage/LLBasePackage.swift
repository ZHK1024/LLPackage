//
//  LLBasePackage.swift
//  LLPackage_Example
//
//  Created by ZHK on 2021/4/26.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import LLPackage

class LLBasePackage: LLPackageAutoSavable {
    
    var fileURL: URL { URL(fileURLWithPath: NSHomeDirectory() + "/Documents/") }
    
    var password: String? { nil }
    
    var kVersionKey: String { "c648b94bc29d70e28445ad87b618b091" }
    
    var request: URLRequest
    
    var overwrite: Bool { true }
    
    /// 是否需要更新
    var isNeedUpdate: Bool { resource.version > version }
    
    /// 本地版本号
    var version: Int {
        set {
            UserDefaults.standard.setValue(newValue, forKey: kVersionKey)
        }
        get {
            UserDefaults.standard.integer(forKey: kVersionKey)
        }
    }
    
    var isNeedUnzip: Bool { true }
    
    var resource: LCResource
    
    // MARK: Init
    
    init?(resource: LCResource) {
        self.resource = resource
        guard let url = URL(string: resource.url) else {
            return nil
        }
        self.request = URLRequest(url: url)
    }
    
    func packageUpdateDidFinished() {
        version = resource.version
        print(version)
    }
    
    deinit {
        print(#function)
    }
}
