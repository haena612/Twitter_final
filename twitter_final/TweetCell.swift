//
//  TweetCell.swift
//  twitter_final
//
//  Created by Haena Kim on 7/23/16.
//  Copyright © 2016 Haena Kim. All rights reserved.
//

import UIKit
import AFNetworking

class TweetCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!

    @IBOutlet weak var retweetOnImage: UIImageView!
    
    @IBOutlet weak var retweetOnLabel: UILabel!
    
    @IBOutlet weak var retweetLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var retweetIconHeight: NSLayoutConstraint!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var replyLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var retweetLabel: UILabel!
    
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var favouriteLabel: UILabel!
    
    @IBAction func replyAction(sender: AnyObject) {
        
    }
    
    @IBAction func retweetAction(sender: UIButton) {
        let selectedTweetCell = sender.superview?.superview as? TweetCell
        TwitterDetail.sharedInstance.retweetHappened((selectedTweetCell?.tweet)!, retweetButton: retweetButton!,retweetLabel: retweetLabel)
    }
    
    @IBAction func favouriteAction(sender: UIButton) {
        let selectedTweetCell = sender.superview?.superview as? TweetCell
        TwitterDetail.sharedInstance.favouriteHappened((selectedTweetCell?.tweet)!,favouriteButton: favouriteButton!,favouriteLabel: favouriteLabel!)
    }
    
    var tweet: Tweet! {
        
        
        didSet {

            TwitterDetail.sharedInstance.setDetail(tweet, profileImage: profileImage, retweetOnImage: retweetOnImage,retweetOnLabel:retweetOnLabel, nameLabel: nameLabel, usernameLabel: usernameLabel,dateLabel: dateLabel,contentLabel: contentLabel, replyButton: replyButton,replyLabel: replyLabel,retweetButton: retweetButton,retweetLabel: retweetLabel,favouriteButton: favouriteButton,favouriteLabel: favouriteLabel,isDetailView: false, retweetLabelHeight: retweetLabelHeight,retweetIconHeight:retweetIconHeight)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
