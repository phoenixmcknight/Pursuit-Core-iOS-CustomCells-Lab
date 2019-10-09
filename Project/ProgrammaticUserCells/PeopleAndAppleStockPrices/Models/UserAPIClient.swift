//
//  UserAPIClient.swift
//  PeopleAndAppleStockPrices
//
//  Created by Phoenix McKnight on 8/30/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
import UIKit
class UserAPIClient {
    static let shared = UserAPIClient()
    
    func getUsers(completionHandler:@escaping (Result <[Results],AppError>)-> Void) {
        
        let userURL =
           
            "https://randomuser.me/api/?results=50"
    
        guard let url = URL(string:userURL ) else {
            return
        }
        NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) {
            (results) in
            switch results {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do { let userData = try JSONDecoder().decode(RandomUsers.self, from: data)
                
                    completionHandler(.success(userData.results))
                } catch let error{
                    completionHandler(.failure(.couldNotParseJSON(rawError: error)))
                }
            }
        }
    }
}
