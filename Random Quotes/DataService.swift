//
//  DataService.swift
//  Random Quotes
//
//  Created by Qaisar Rizwan on 19/04/2017.
//  Copyright © 2017 Qaisar Rizwan. All rights reserved.
//

import Foundation
import UIKit


class DataService {
    
    func getQuoteData(completion:@escaping (_ quote: String, _ author: String?) -> ()) {
        
        let url = URL(string: "http://api.forismatic.com/api/1.0/?method=getQuote&lang=en&format=json")!
        
        URLSession.shared.dataTask(with: url, completionHandler: { ( data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            do {
                let jsonDictionary = try JSONSerialization.jsonObject(with: data! , options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                
                
                let aQuote = jsonDictionary["quoteText"] as! String
                let aAuthor = jsonDictionary["quoteAuthor"] as! String
                
                DispatchQueue.main.async(execute: { () -> Void in
                    completion(aQuote, aAuthor)
                })
                
            } catch {
                print("invalid json query")
            }
        }).resume()
    }
    
}
