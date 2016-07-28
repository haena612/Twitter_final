//
//  User.swift
//  twitter_final
//
//  Created by Haena Kim on 7/23/16.
//  Copyright © 2016 Haena Kim. All rights reserved.
//

import Foundation

class User: NSObject{
    
    //store property - stroage exists
    var name: String?
    var screenname: NSString?
    var profileUrl: NSURL?
    var tagline: NSString?
    
    var dictionary: NSDictionary?
    
    
    init(dictionary: NSDictionary) {
        
        self.dictionary = dictionary
        
        //        print(user["name"] as! String)
        //        print(user["screen_name"] as! String)
        //        print(user["profile_image_url_https"] as! String)
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        // sorrHyEyRyE. im wrong >< this iYAY!s the profile image
        let profileUrlString = dictionary["profile_image_url"] as? String
        
        if let profileUrlString = profileUrlString{
            profileUrl = NSURL(string: profileUrlString)
        }else{
            profileUrl = nil
        }
        tagline = dictionary["description"] as? String
    }
    
    static let userDidLogOutNotification = "UserDidLogout"
    //computed property - no storage - ex.var for the first, last names, full name (return logic first + last)
    
    static var _currentUser: User?
    
    class var currentUser: User? {
        get{
            if _currentUser == nil{
                let defaults = NSUserDefaults.standardUserDefaults()
                let userData = defaults.objectForKey("currentUserData") as? NSData
                
                if let userData = userData {
                    let dictionary = try! NSJSONSerialization.JSONObjectWithData(userData, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            
            return _currentUser
        }
    set(user){
        _currentUser = user
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let user = user {
            let data = try! NSJSONSerialization.dataWithJSONObject(user.dictionary!,options: [])
            
            defaults.setObject(data, forKey: "currentUserData")
        } else  {
            defaults.setObject(nil, forKey: "currentUserData")
        }
        defaults.synchronize()
    
        }
    }
    
}
