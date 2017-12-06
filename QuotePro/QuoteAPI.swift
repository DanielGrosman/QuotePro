//
//  QuoteAPI.swift
//  QuotePro
//
//  Created by Daniel Grosman on 2017-12-06.
//  Copyright © 2017 Daniel Grosman. All rights reserved.
//

import UIKit
import Foundation

class QuoteAPI: NSObject {
    func generateQuote(completionHandler: @escaping (String, String) -> Void) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        let quoteURL = URL(string: "http://api.forismatic.com/api/1.0/?method=getQuote&lang=en&format=json")
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
            var json: Any?
            do {
                json = try JSONSerialization.jsonObject(with: data)
            }
            catch {
                print(#line, error.localizedDescription)
            }
            guard let quotes = json as? [String: Any] else {
                return
            }
            
            let quote = quotes["quoteText"] as? String
            let author = quotes["quoteAuthor"] as? String
            completionHandler (quote!,author!)
            
            
        })
        task.resume()
        session.finishTasksAndInvalidate()
    }
}

