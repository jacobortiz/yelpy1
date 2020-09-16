//
//  File.swift
//  Yelpy
//
//  Created by Memo on 5/21/20.
//  Copyright © 2020 memo. All rights reserved.
//

import Foundation


struct API {
    

    
    static func getRestaurants(completion: @escaping ([[String:Any]]?) -> Void) {
        
        // ––––– TODO: Add your own API key!
        let apikey = "2gt4_8YgYsIMogZOXEcoWYmKaYwom6UvIU6SH9mkdhX15-AcsDrKjY2FBvE9HDjdFSRRp6-suLex6PN1Ih7EQqktp4Mm_IFWwmvZUxJlqZ5WG23ZESGhf-fK8FFhX3Yx"
        
        // Coordinates for San Francisco
        let lat = 37.773972
        let long = -122.431297
        
        
        let url = URL(string: "https://api.yelp.com/v3/transactions/delivery/search?latitude=\(lat)&longitude=\(long)")!
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        // Insert API Key to request
        request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                // ––––– TODO: Get data from API and return it using completion
                print(data)
                // convert json response to dictionary
                let data_dictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                // grab business data and convert it to an array of dictionaries
                let restaurants = data_dictionary["businesses"] as! [[String: Any]]
                return completion(restaurants)
                
                //return completion([[:]])
        
                }
            }
        
            task.resume()
        
        }
    }

    
