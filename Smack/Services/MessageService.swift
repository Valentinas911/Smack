//
//  MessageService.swift
//  Smack
//
//  Created by Valentinas Mirosnicenko on 4/30/18.
//  Copyright © 2018 Valentinas Mirosnicenko. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    
    static let instance = MessageService()
    
    var channels = [Channel]()
    var selectedChannel:Channel?
    
    func findAllChannel(completion: @escaping CompletionHandler) {
        
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                // MARK: - Method 1
//                guard let data = response.data, let json = try? JSON(data:data).array else { return }
//                
//                for item in json! {
//                    let name = item["name"].stringValue
//                    let channelDescription = item["description"].stringValue
//                    let id = item["_id"].stringValue
//                    
//                    let channel = Channel(channelTitle: name, channelDescription: channelDescription, id: id)
//                    self.channels.append(channel)
//                }
                
                // MARK: - Method 2
                guard let data = response.data else { return }
                
                do {
                    self.channels = try JSONDecoder().decode([Channel].self, from: data)
                } catch let error {
                    debugPrint(error as Any)
                }
                NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error.debugDescription)
            }
        }
    
    }
    
    func clearChannels() {
        channels.removeAll()
    }
    
}
