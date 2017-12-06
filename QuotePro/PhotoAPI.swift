//
//  PhotoAPI.swift
//  QuotePro
//
//  Created by Daniel Grosman on 2017-12-06.
//  Copyright © 2017 Daniel Grosman. All rights reserved.
//

import UIKit

class PhotoAPI: NSObject {
    
    func generatePhoto(completionHandler: @escaping (UIImage) -> Void) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        let quoteURL = URL(string: "http://lorempixel.com/300/250/")
        var request = URLRequest(url: quoteURL!)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if let error = error {
                print(#line, error)
                return
            }
            guard (response as! HTTPURLResponse).statusCode == 200 else { return }
            guard let data = data else {
                print(#line, "no data")
                return
            }
            
            let image = UIImage(data:data)
            completionHandler (image!)

        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
}


