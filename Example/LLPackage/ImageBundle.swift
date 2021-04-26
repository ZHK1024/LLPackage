//
//  ImageBundle.swift
//  LLPackage_Example
//
//  Created by ZHK on 2021/4/26.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import LLPackage

class ImageBundle: LLBasePackage {
    
    override var fileURL: URL { URL(fileURLWithPath: NSHomeDirectory() + "/Documents/main.jpeg") }
    
    override var kVersionKey: String { "c648b94bc29d70e28445ad87b618b091" }

    override var overwrite: Bool { true }
    
    override var isNeedUnzip: Bool { false }

}
