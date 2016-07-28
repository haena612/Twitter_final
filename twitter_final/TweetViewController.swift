//
//  TweetViewController.swift
//  twitter_final
//
//  Created by Haena Kim on 7/23/16.
//  Copyright © 2016 Haena Kim. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController{

    @IBOutlet weak var tableView: UITableView!

    
    var tweets = [Tweet]()
    var refreshControl = UIRefreshControl()
    
    @IBAction func onLogOutButton(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.estimatedRowHeight = 200
        self.tableView.rowHeight = UITableViewAutomaticDimension

        loadHomeTimeline()
        
        self.refreshControl.addTarget(self, action: #selector(TweetViewController.loadHomeTimeline), forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
    
    }

    func loadHomeTimeline(){
        TwitterClient.sharedInstance.homeTimeline({ (tweets: [Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
        }) { (error: NSError) in
            print("Got error when fetching timeline: \(error.localizedDescription)")
        }
        refreshControl.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//         Get the new view controller using segue.destinationViewController.
//         Pass the selected object to the new view controller.
        
        let navigationController = segue.destinationViewController as! UINavigationController
            
            if navigationController.topViewController is UpdateViewController {
                let updateViewController = navigationController.topViewController as! UpdateViewController
                updateViewController.delegate = self
                
                if segue.identifier == "replySegue" {
                    if let selectedCell = sender!.superview!!.superview as? TweetCell {
                        let selectedTweet = selectedCell.tweet
                        updateViewController.tweetReply = selectedTweet
                    }
                }
            } else if navigationController.topViewController is DetailViewController {
                let detailViewController = navigationController.topViewController as! DetailViewController
                detailViewController.delegate = self
                
                var indexPath: AnyObject!
                indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
                
                detailViewController.selectedTweet = tweets[indexPath!.row]
                detailViewController.indexPath = indexPath! as? NSIndexPath
            }
            
        }

    }
    

//


extension TweetViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell") as! TweetCell
        cell.tweet = tweets[indexPath.row]
        
        cell.contentLabel.numberOfLines = 0
        cell.contentLabel.sizeToFit()
        
        return cell
        
        //cell.textLabel?.text = tweets[indexPath.row]
    }
    
}


extension TweetViewController: UpdateViewControllerDelegate{

    func updateViewController(updateViewController: UpdateViewController, didUpdateTweet updateTweet: Tweet){
        tweets.insert(updateTweet, atIndex: 0)
        tableView.reloadData()
    }
}

extension TweetViewController: DetailViewControllerDelegate{
    
    func detailViewController(detailViewController: DetailViewController, didUpdateTweet selectedTweet: Tweet, indexPath: NSIndexPath?, replyTweet: Tweet?){
        tableView.reloadData()
    }
}