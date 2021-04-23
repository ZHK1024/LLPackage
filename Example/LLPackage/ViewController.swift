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
    
    var promise: LLPromise<Bool>?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        LLPackage.sync(package: H5Bundle.self) { (success, error) in
            print(success, error)
        }
    }

}

