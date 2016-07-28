//
//  Tweet.swift
//  twitter_final
//
//  Created by Haena Kim on 7/23/16.
//  Copyright © 2016 Haena Kim. All rights reserved.
//

import UIKit

class Tweet: NSObject{

    var text: String?
    var timestamp: NSDate?
    var retweetCount: Int?
    var favouriteCount: Int?
    var id: NSNumber?
    var user: User?
    var replyToStatusId: NSNumber?
    var replyToScreenName: String?
    var createdAtString: String?
    var isRetweeted = false
    var isFavourited = false
    var images = [NSURL]()
    var retweet: Tweet?
    


    init(dictionary: NSDictionary) {
        
        text = dictionary["text"] as? String
        
        retweetCount = dictionary["retweet_count"] as? Int!
        
        favouriteCount = dictionary["favorite_count"] as? Int
        
        let timestampString = dictionary["created_at"] as? String

        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        
        if let timestampString = timestampString{
            timestamp = formatter.dateFromString(timestampString)
        }
    
        id = dictionary["id"] as? NSNumber
        
        user = User(dictionary: (dictionary ["user"] as? NSDictionary)!)
        
        replyToStatusId = dictionary["in_reply_to_status_id"] as? NSNumber!
        
        replyToScreenName = dictionary["in_reply_to_screen_name"] as? String!
        
        isRetweeted = (dictionary["retweeted"] as? Bool!)!
        
        isFavourited = (dictionary["favorited"] as? Bool!)!
        
    }
    
    class func tweetswWithArray(dictionaries: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        
        for dictionary in dictionaries{
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        return tweets
    }
    
    func formattedDateDetailView () -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = .ShortStyle
        
        let dateString = dateFormatter.stringFromDate(timestamp!)
        
        return dateString
    }

    func formattedIntervalTime() -> String{
    
        let min = 60
        let hour = min * 60
        let day = hour * 24
        let week = day * 7
        
        let timePassed = NSDate().timeIntervalSinceDate(timestamp!)
        let duration = Int(timePassed)
        
        if duration < min {
            return "\(duration) sec"
        }else if duration >= min && duration < hour {
            let durationMin = duration/min
            return "\(durationMin) min"
        }else if duration >= hour && duration < day {
            let durationHour = duration/hour
            return "\(durationHour) hour"
        }else if duration >= day && duration < week {
            let durationDay = duration/day
            return "\(durationDay) day"
        }else {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "m/d/yy"
            let dateString = dateFormatter.stringFromDate(timestamp!)
            
            return dateString
        }

    }
}