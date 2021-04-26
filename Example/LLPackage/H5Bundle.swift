//
//  H5Bundle.swift
//  LLPackage_Example
//
//  Created by ZHK on 2021/4/23.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import LLPackage

class H5Bundle: LLBasePackage {
    
    override var fileURL: URL { URL(fileURLWithPath: NSHomeDirectory() + "/Documents/h5.bundle") }
    
    override var kVersionKey: String { "76e136e032690a623f384e03135f1348" }

    override var overwrite: Bool { true }
    
    override var isNeedUnzip: Bool { true }

}
