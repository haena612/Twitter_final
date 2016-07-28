//
//  TwitterDetail.swift
//  twitter_final
//
//  Created by Haena Kim on 7/26/16.
//  Copyright © 2016 Haena Kim. All rights reserved.
//

import UIKit

class TwitterDetail: NSObject{
    
    //    static var sharedInstance = TwitterDetail()
    
class var sharedInstance: TwitterDetail{
        struct Static {
            static let instance = TwitterDetail()
        }
        
        return Static.instance
    }
    
    func retweetHappened(selectedTweet:Tweet,retweetButton: UIButton!,retweetLabel: UILabel! ){
        if selectedTweet.isRetweeted{
            let newRetweetCount = selectedTweet.retweetCount! - 1
            selectedTweet.retweetCount = newRetweetCount
            retweetLabel.text = "\(newRetweetCount)"
            retweetButton.setImage(UIImage(named: "retweet"), forState: .Normal)
            selectedTweet.isRetweeted = !selectedTweet.isRetweeted
        } else {
            let newRetweetCount = selectedTweet.retweetCount! + 1
            selectedTweet.retweetCount = newRetweetCount
            retweetLabel.text = "\(newRetweetCount)"
            retweetButton.setImage(UIImage(named: "retweet_on"), forState: .Normal)
            selectedTweet.isRetweeted = !selectedTweet.isRetweeted
        }
    }
    
    func favouriteHappened(selectedTweet:Tweet,favouriteButton: UIButton!,favouriteLabel: UILabel! ){
        if selectedTweet.isFavourited{
            let newFavouriteCount = selectedTweet.favouriteCount! - 1
            selectedTweet.favouriteCount = newFavouriteCount
            favouriteLabel.text = "\(newFavouriteCount)"
            favouriteButton.setImage(UIImage(named: "favorite"), forState: .Normal)
            selectedTweet.isFavourited = !selectedTweet.isFavourited
        } else {
            let newFavouriteCount = selectedTweet.favouriteCount! + 1
            selectedTweet.favouriteCount = newFavouriteCount
            favouriteLabel.text = "\(newFavouriteCount)"
            favouriteButton.setImage(UIImage(named: "favorite_on"), forState: .Normal)
            selectedTweet.isFavourited = !selectedTweet.isFavourited

        }
    }
    
    func setDetail(selectedTweet: Tweet!, profileImage: UIImageView!, retweetOnImage: UIImageView!,retweetOnLabel: UILabel!, nameLabel: UILabel!,usernameLabel: UILabel!,dateLabel: UILabel!,contentLabel: UILabel!, replyButton: UIButton!,replyLabel: UILabel!,retweetButton: UIButton!,retweetLabel: UILabel!,favouriteButton: UIButton!,favouriteLabel: UILabel!,isDetailView: Bool, retweetLabelHeight:NSLayoutConstraint,retweetIconHeight:NSLayoutConstraint) {
        
        var tweet = selectedTweet
        
        profileImage.setImageWithURL((tweet.user?.profileUrl)!)
        
        
        if let retweet = tweet.retweet {
            if let name = tweet.user?.name {
                retweetOnLabel.text = "\(name) retweeted"
                retweetOnImage.image = UIImage(named: "retweet_on")
                retweetLabelHeight.constant = 12
                retweetIconHeight.constant = 10
            }
            tweet = retweet
        }
        else if let replyTweetName = tweet.replyToScreenName {
            retweetOnLabel.text = "In reply to @\(replyTweetName)"
            retweetOnImage.image = UIImage(named: "reply_hover")
            retweetLabelHeight.constant = 12
            retweetIconHeight.constant = 10
        } else {
            retweetLabelHeight.constant = 0
            retweetIconHeight.constant = 0
        }
        
        nameLabel.text = tweet.user?.name
        
        if let screenName = tweet.user?.screenname {
            usernameLabel.text = "@\(screenName)"
        }
        
        if isDetailView {
            dateLabel.text = tweet.formattedDateDetailView()
        } else {
            dateLabel.text = tweet.formattedIntervalTime()
        }
        
        contentLabel.text = tweet.text

        
        if let tweetCount = tweet.retweetCount {
            if tweetCount > 0 {
                retweetLabel.text = "\(tweetCount)"
            } else {
                retweetLabel.text = "0"
            }
        }
        
        if let favouriteCount = tweet.favouriteCount {
            if favouriteCount > 0 {
                favouriteLabel.text = "\(favouriteCount)"
            } else {
                favouriteLabel.text = "0"
            }
        }
        
        //             set appropriate images for retweet button and favorite button
        if tweet.isRetweeted {
            retweetButton.setImage(UIImage(named: "retweet_on"), forState: .Normal)
        } else {
            retweetButton.setImage(UIImage(named: "retweet"), forState: .Normal)
        }
        
        if tweet.isFavourited {
            favouriteButton.setImage(UIImage(named: "favorite_on"), forState: .Normal)
        } else {
            favouriteButton.setImage(UIImage(named: "favorite"), forState: .Normal)
        }
        
        
        replyButton.setImage(UIImage(named: "reply"), forState: .Normal)
        
        //Prevent retweet button when the tweet is current user's tweet
        if let currentUser = User.currentUser {
            if tweet.user?.screenname == currentUser.screenname {
                retweetButton.enabled = false
            } else {
                retweetButton.enabled = true
            }
        }
    }
}