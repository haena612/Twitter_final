//
//  DetailViewController.swift
//  twitter_final
//
//  Created by Haena Kim on 7/28/16.
//  Copyright © 2016 Haena Kim. All rights reserved.
//

import UIKit

@objc protocol DetailViewControllerDelegate {
    optional func detailViewController(detailViewController: DetailViewController, didUpdateTweet selectedTweet: Tweet, indexPath: NSIndexPath?, replyTweet: Tweet?)
}

class DetailViewController: UIViewController, UITextViewDelegate {


    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
@IBOutlet weak var replyOnLabel: UILabel!
    @IBOutlet weak var replyOnIcon: UIImageView!

    @IBOutlet weak var replyIcon: UIButton!
    @IBOutlet weak var replyLabel: UILabel!

    @IBOutlet weak var retweetIcon: UIButton!
    @IBOutlet weak var retweetLabel: UILabel!

    
    @IBOutlet weak var favouriteIcon: UIButton!
    @IBOutlet weak var favouriteLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    

    @IBOutlet weak var retweetlabelheight: NSLayoutConstraint!
    @IBOutlet weak var retweeticonheight: NSLayoutConstraint!
    
    var selectedTweet: Tweet?
    var indexpath: NSIndexPath?
    var replyTweet: Tweet?
    var indexPath: NSIndexPath?
    
    weak var delegate: DetailViewControllerDelegate?
    
    @IBAction func backAction(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func replyAction(sender: AnyObject) {
    }
    
    @IBAction func retweenAction(sender: AnyObject) {
        TwitterDetail.sharedInstance.retweetHappened(selectedTweet!,retweetButton: retweetIcon,retweetLabel: retweetLabel )
    }
 
    @IBAction func favouriteAction(sender: AnyObject) {
        TwitterDetail.sharedInstance.favouriteHappened(selectedTweet!, favouriteButton: favouriteIcon, favouriteLabel: favouriteLabel)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        
        TwitterDetail.sharedInstance.setDetail(selectedTweet, profileImage: profileImage, retweetOnImage: replyOnIcon ,retweetOnLabel: retweetLabel, nameLabel: nameLabel,usernameLabel: screenNameLabel,dateLabel: dateLabel,contentLabel: contentLabel, replyButton: replyIcon,replyLabel: replyLabel,retweetButton: retweetIcon,retweetLabel: retweetLabel,favouriteButton: favouriteIcon,favouriteLabel: favouriteLabel,isDetailView: true, retweetLabelHeight:retweetlabelheight,retweetIconHeight:retweeticonheight)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
