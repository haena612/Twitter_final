//
//  UpdateViewController.swift
//  twitter_final
//
//  Created by Haena Kim on 7/26/16.
//  Copyright © 2016 Haena Kim. All rights reserved.
//

import UIKit

@objc protocol UpdateViewControllerDelegate {
    optional func updateViewController(updateViewController: UpdateViewController, didUpdateTweet updateTweet: Tweet)
}

class UpdateViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var replyIcon: UIImageView!
    @IBOutlet weak var replyLabel: UILabel!
    
    @IBOutlet weak var newTweet: UITextView!
    
    weak var delegate: UpdateViewControllerDelegate?
    
    var tweetReply: Tweet?
    var replyVersion:Bool = true
    
    @IBAction func tweetAction(sender: AnyObject) {
        if let reply = tweetReply {
            TwitterClient.sharedInstance.updateReplyTweet(newTweet.text, numID: reply.id!, success: {(tweet) -> () in
                let newTweet = tweet
                
                if let newTweet = newTweet {
                    print("Reply!")
                    self.delegate?.updateViewController?(self, didUpdateTweet: newTweet)
                    
                    self.dismissViewControllerAnimated(true, completion: nil)
                    }
                },
                    failure: {_ in (task: NSURLSessionDataTask?, error: NSError).self
            })
        } else {
            TwitterClient.sharedInstance.updateNewTweet(newTweet.text, success: {(tweet) -> () in
                if let newText = tweet {
                    print("New Tweet!")
                    self.delegate?.updateViewController!(self, didUpdateTweet: newText)
                }
                self.dismissViewControllerAnimated(true, completion: nil)
                
                },
                failure: {_ in (task: NSURLSessionDataTask?, error: NSError).self
            })
        }
    }
    
    @IBAction func cancelAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newTweet.delegate = self
        
        if replyVersion{
            if let replyWho = tweetReply?.user?.name {
                self.navigationItem.title = "Reply"
                replyLabel.text = "In reply to @\(replyWho)"
                replyIcon.image = UIImage(named: "reply_on")
        } else {
                self.navigationItem.title = "New Tweet"
                replyLabel.hidden = true
                replyIcon.hidden = true
            }
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
