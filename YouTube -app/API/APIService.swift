//
//  APIService.swift
//  YouTube -app
//
//  Created by 酒井ゆうき on 2020/04/16.
//  Copyright © 2020 Yuuki sakai. All rights reserved.
//

import UIKit

class APIService {
    
    static let shared = APIService()
    
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    
    func fetchVideos(completion :  @escaping ([Video]) -> Void) {
        fetchFeedForUrlString(urlStrig: "\(baseUrl)/home.json", completion: completion)
    }
    
    func fetchTrends(completion :  @escaping([Video]) -> Void) {
         fetchFeedForUrlString(urlStrig: "\(baseUrl)/trending.json", completion: completion)
    }
    
    func fetchSubscriptions(completion :  @escaping([Video]) -> Void) {
        fetchFeedForUrlString(urlStrig: "\(baseUrl)/subscriptions.json", completion: completion)
    }
    
    func fetchFeedForUrlString(urlStrig: String, completion :  @escaping ([Video]) -> Void) {
        guard let url = URL(string: urlStrig) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, responce, error) in
            
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            do {
                guard let data = data else {return}
                let decorder = JSONDecoder()
                decorder.keyDecodingStrategy = .convertFromSnakeCase
                let videos = try decorder.decode([Video].self, from: data)
                
                DispatchQueue.main.async {
                    completion(videos)
                }
                
            }
            catch let jsonError {
                print(jsonError)
            }
        }.resume()
        
    }
    
}
