//
//  QueryService.swift
//  nasa_app
//
//  Created by Grady Jenkins on 12/20/18.
//  Copyright © 2018 Grady Jenkins. All rights reserved.
//

import Foundation
class QueryService {
    typealias ErrorResult = ((String) -> Void)?
    
    func fetch<T: Decodable>(url: String, completion: @escaping (T) -> Void, onError: ErrorResult = nil) {
        guard let url = URL(string: url) else {
            onError?("Url invalid.")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            var errorString: String?
            
            defer {
                if let errorString = errorString {
                    DispatchQueue.main.async {
                        onError?(errorString)
                    }
                }
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                errorString = "Network error occured."
                return
            }
            
            //If error exists, call error closure
            guard error == nil else {
                errorString = "Unexpected error occurred."
                return
            }
            
            //Check if data exists
            guard let data = data else {
                errorString = "Data error occurred."
                return
            }
            
            //Decode json into list of generic models and call completion closure
            guard let items = try? JSONDecoder().decode(T.self, from: data) else {
                errorString = "Data serialization error occurred."
                return
            }
            
            DispatchQueue.main.async {
                completion(items)
            }
            }.resume()
    }
}
