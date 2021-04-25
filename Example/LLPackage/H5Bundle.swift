//
//  H5Bundle.swift
//  LLPackage_Example
//
//  Created by ZHK on 2021/4/23.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import LLPackage
//import LLPackage.Zip

struct H5Bundle: LLPackageUpdatable {
    
    static var overwrite: Bool = false
    
    
    struct CheckData: Decodable {
        let data: Data
        struct Data: Decodable {
            let version: Int
            let url: String
        }
    }
    
    static var request: URLRequest {
        URLRequest(url: URL(string: "http:/192.168.3.210:8080/Storyboard.bundle.zip")!)
    }
    
    static var isZip: Bool { true }
    
    
    
    static func check() -> LLPromise<Bool> {
        let promise = LLPromise<Bool>()
        URLSession.shared.dataTask(with: URL(string: "http:/192.168.3.210:8080/config")!) { (data, response, error) in
            guard let jsonData = data else {
                promise.reject(error ?? NSError(domain: "", code: 0, userInfo: [
                    NSLocalizedDescriptionKey : ""
                ]))
                return
            }
            do {
                let check = try JSONDecoder().decode(CheckData.self, from: jsonData)
                promise.fulfill(value: check.data.version > 4)
                print(check.data.version)
            } catch {
                promise.reject(error)
            }
        }.resume()
        return promise
    }
    
    static func replace(tempURL: URL, response: URLResponse?) {
        print(tempURL.absoluteURL)
        let url = URL(fileURLWithPath: NSHomeDirectory() + "/Documents/H5Bundle.zip")
        print(url)
        do {
            if FileManager.default.fileExists(atPath: url.path) {
                _ = try FileManager.default.replaceItemAt(url, withItemAt: tempURL)
            } else {
                try FileManager.default.moveItem(at: tempURL.absoluteURL, to: url)
            }
        } catch {
            print(error)
        }
    }
}
