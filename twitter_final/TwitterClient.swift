//
//  TwitterClient.swift
//  twitter_final
//
//  Created by Haena Kim on 7/23/16.
//  Copyright © 2016 Haena Kim. All rights reserved.
//

import Foundation
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager{
    
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string:"https://api.twitter.com")!, consumerKey: "ipxIx3wFLH5t3zjNFX1MnC0z4", consumerSecret: "4vBUhXxV7IDfpVYtjD8wq2suC06oeWJ1o2kvHSLLPo5KsrR3pM")
    
    func handleOpenUrl( url: NSURL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        print(requestToken)
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: {(accessToken: BDBOAuth1Credential!
            ) in
            
            self.currentAccount({ (user: User) -> () in
                User.currentUser = user // setter user info
                self.loginSuccess?()
                }, failure: { (error: NSError) -> () in
                self.loginFailure?(error)
            })
    
            print("I got the access token = \(accessToken.token)" )
            self.loginSuccess?()
            
        }) { (error: NSError!) in
            print("Error: \(error.localizedDescription)")
            self.loginFailure?(error)
        }
    }
    
    //(closure: take value but return nothing, Just store)
    // call this one in tweetviewcontroller AHHHH
    func homeTimeline(success: ([Tweet]) -> (), failure: (NSError) -> ()) {
        
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response) in
            
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetswWithArray(dictionaries)
            
            
            success(tweets) // need to call the closure
            
            //            for tweet in tweets{
            //            print("\(tweet.text!)")
            //            }!
            
            }, failure: {(task: NSURLSessionDataTask?, error: NSError) in
                failure(error)
        })
        
    }

    func userTimeline(success: ([Tweet]) -> (), failure: (NSError) -> ()) {
        
        GET("1.1/statuses/user_timeline.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response) in
            
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetswWithArray(dictionaries)
            
            
            success(tweets) // need to call the closure
            
            //            for tweet in tweets{
            //            print("\(tweet.text!)")
            //            }
            
            }, failure: {(task: NSURLSessionDataTask?, error: NSError) in
                failure(error)
        })
        
    }
    
    
    func login(success: () -> (), failure: (NSError) -> () ){
        
        loginSuccess = success
        loginFailure = failure
        
        deauthorize()
        
        fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string:"twitterFinal://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            print("I got the token!")
            
            let url = NSURL(string:"https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            UIApplication.sharedApplication().openURL(url)
            
        }) {
            (error: NSError!) -> Void in
            print("\(error.localizedDescription)")
            self.loginFailure?(error)
        }
        
    }
    
    func logout(){
        User.currentUser = nil
        deauthorize()
        
        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogOutNotification, object: nil)
    }
    
    func currentAccount( success: (User) -> (), failure: (NSError) -> ()) {
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response) in
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            
            success(user)
            
            print(user.name)
            print(user.screenname)
            print(user.profileUrl)
            
            }, failure: {(task: NSURLSessionDataTask?, error: NSError) in
                print("Error: \(error.localizedDescription)")
                failure(error)
        })
        
    }
    
    func updateNewTweet( newTweetText: String, success: (Tweet?) -> (), failure: (NSError) -> ()) {
        
        var paramInfo = [String: AnyObject]()
        paramInfo["status"] = newTweetText
        
        POST("1.1/statuses/update.json", parameters: paramInfo, progress: nil, success: { (task: NSURLSessionDataTask, response) in
            let tweetText = response as! NSDictionary
            let newtweetText = Tweet(dictionary: tweetText)
            
            success(newtweetText)
            
            }, failure: {(task: NSURLSessionDataTask?, error: NSError) in
                print("Error: \(error.localizedDescription)")
                print("bahhhhh newtweet error")
                failure(error)
        })
        
    }
    
    func updateReplyTweet( newTweetText: String, numID: NSNumber, success: (Tweet?) -> (), failure: (NSError) -> ()) {
        
        var paramInfo = [String: AnyObject]()
        paramInfo["status"] = newTweetText
        paramInfo["in_reply_to_status_id"] = numID
        
        POST("1.1/statuses/update.json", parameters: paramInfo, progress: nil, success: { (task: NSURLSessionDataTask, response) in
            let tweetText = response as! NSDictionary
            let newtweetText = Tweet(dictionary: tweetText)
            
            success(newtweetText)
            
            }, failure: {(task: NSURLSessionDataTask?, error: NSError) in
                print("Error: \(error.localizedDescription)")
                print("bahhhhh reply error")
                failure(error)
        })
        
    }

}
