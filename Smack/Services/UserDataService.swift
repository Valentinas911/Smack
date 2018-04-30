//
//  UserDataService.swift
//  Smack
//
//  Created by Valentinas Mirosnicenko on 4/29/18.
//  Copyright © 2018 Valentinas Mirosnicenko. All rights reserved.
//

import Foundation

class UserDataService {
    
    static let instance = UserDataService()
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
    func setUserData(id: String, avatarColor: String, avatarName: String, email: String, name: String) {
        self.id = id
        self.avatarColor = avatarColor
        self.avatarName = avatarName
        self.email = email
        self.name = name
    }
    
    func setAvatarName(avatarName: String) {
        self.avatarName = avatarName
    }
    
    func returnUIColor(components: String) -> UIColor {
        
        let defaultColor = UIColor.lightGray
        let scanner = Scanner(string: components)
        let skipped = CharacterSet(charactersIn: "[], ")
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skipped
        
        var r, g , b , a : NSString?
        
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        guard let rUnrwapped = r else { return defaultColor }
        guard let gUnrwapped = g else { return defaultColor }
        guard let bUnrwapped = b else { return defaultColor }
        guard let aUnrwapped = a else { return defaultColor }
        
        let rCGFloat = CGFloat(rUnrwapped.doubleValue)
        let gCGFloat = CGFloat(gUnrwapped.doubleValue)
        let bCGFloat = CGFloat(bUnrwapped.doubleValue)
        let aCGFloat = CGFloat(aUnrwapped.doubleValue)
        
        let newUIColor = UIColor(red: rCGFloat, green: gCGFloat, blue: bCGFloat, alpha: aCGFloat)
        
        return newUIColor
        
    }
    
}
