//
//  AuthService.swift
//  Smack
//
//  Created by Valentinas Mirosnicenko on 4/29/18.
//  Copyright © 2018 Valentinas Mirosnicenko. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class AuthService {
    
    static let instance = AuthService()
    
    private let defaults = UserDefaults.standard
    
    var isLoggedIn: Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        } set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken: String {
        get {
            return defaults.string(forKey: TOKEN_KEY)!
        } set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail: String {
        get {
            return defaults.string(forKey: USER_EMAIL)!
        } set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler) {
        
        let lowerCasedEmail = email.lowercased()

        let body:[String:Any] = [
            "email":lowerCasedEmail,
            "password":password
        ]
        
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
            if response.result.error == nil {
                completion(true)
                print(response.result)
            } else {
                completion(false)
                debugPrint(response.result.error.debugDescription)
            }
        }
        
    }
    
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler) {
        let lowerCasedEmail = email.lowercased()
        
        let body:[String:Any] = [
            "email":lowerCasedEmail,
            "password":password
        ]
        
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if response.result.error == nil {
                
                // Method 1 (no SwiftyJSON)
//                if let json = response.result.value as? Dictionary<String,Any> {
//                    if let email = json["user"] as? String {
//                        self.userEmail = email
//                    }
//
//                    if let token = json["token"] as? String {
//                        self.authToken = token
//                    }
//                }
                
                // This is only used with Method 2 and 3
//                guard let data = response.data else { return }
                
                // Method 2 (Using SwiftyJSON)
//                do {
//                    let json = try JSON(data: data)
//                    self.userEmail = json["user"].stringValue
//                    self.authToken = json["token"].stringValue
//                } catch {
//                    debugPrint("Error when converting to JSON Object")
//                }
                
                // Method 3 (Using SwiftyJSON) + if let
//                if let json = try? JSON(data:data) {
//                    self.userEmail = json["user"].stringValue
//                    self.authToken = json["token"].stringValue
//                }
                
                // Method 4 (Using SwiftyJSON) + guard let
                guard let data = response.data, let json = try? JSON(data:data) else { return }
                self.userEmail = json["user"].stringValue
                self.authToken = json["token"].stringValue
                
                self.isLoggedIn = true
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error.debugDescription)
            }
            
        }
        
    }
    
    
    
}
