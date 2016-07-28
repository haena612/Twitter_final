//
//  LogInViewController.swift
//  twitter_final
//
//  Created by Haena Kim on 7/22/16.
//  Copyright © 2016 Haena Kim. All rights reserved.
//

import UIKit
import BDBOAuth1Manager


class LogInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginButton(sender: UIButton) {

        TwitterClient.sharedInstance.login({ () -> () in
            print("I've logged in!")
            self.performSegueWithIdentifier("loginSegue", sender: self) // if success login, the screen will move to 'TweetViewController'
        }) { (error: NSError) -> () in
            print("Error: \(error.localizedDescription)")
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
