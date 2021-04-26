//
//  ViewController.swift
//  LLPackage
//
//  Created by ruris on 04/23/2021.
//  Copyright (c) 2021 ruris. All rights reserved.
//

import UIKit
import LLPackage

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(NSHomeDirectory())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let checkRequest = URLRequest(url: URL(string: "http:/192.168.3.210:8080/resource")!)
        
        let checker = LLPackageChecker<LCResult>(request: checkRequest)
        LLPackage.sync(checker) { config in
            config.data.compactMap { data -> LLBasePackage? in
                switch data.name {
                case .h5:
                    return H5Bundle(resource: data)
                case .image:
                    return ImageBundle(resource: data)
                }
            }
        } complete: {
            switch $0 {
            case .success(let res):
                print(res)
            case .failure(let error):
                print(error)
            }
        }
    }

}

struct LCResult: Decodable {
    
    let data: [LCResource]
}

struct LCResource: Decodable {
    
    let version: Int
    
    let url: String
    
    let name: RespurceName
}


enum RespurceName: String, Decodable {
    case h5
    case image
}
