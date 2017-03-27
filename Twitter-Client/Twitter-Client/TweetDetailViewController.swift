//
//  TweetDetailViewController.swift
//  Twitter-Client
//
//  Created by Annie Ton-Nu on 3/22/17.
//  Copyright © 2017 Annie Ton-Nu. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
    
    var tweet : Tweet!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet weak var retweetStatusView: UIView!
    
    @IBOutlet weak var retweetStatusLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Tweet Details"
        
        self.navigationController?.navigationBar.tintColor = UIColor.purple  //to set navigation item text to a different color
        
//        self.navigationController?.navigationBar.barTintColor = UIColor.darkGray //set nav bar to a diff color. can also in main.storyboard
        
        
        self.userNameLabel.text = self.tweet.user?.name ?? "Unknown"
        
        self.tweetTextLabel.text = self.tweet.text
        
        print("User screenname is: \(tweet.user?.screenName)")
        
        if self.tweet.retweetedStatus {
            self.retweetStatusLabel.text = "Retweet"
            self.retweetStatusView.backgroundColor = UIColor.yellow
        } else {
            self.retweetStatusLabel.text = "Not a retweet"
            self.retweetStatusView.backgroundColor = UIColor.cyan
        }
   
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "UserFeedViewControllerSegue" {
            
            let tweetUser = tweet.user
            
            if let destinationController = segue.destination as? UserFeedViewController {
                destinationController.newUser = tweetUser
            }
        }
        
        
    }
    
}























//another way of doing this

//override func viewDidLoad() {
//    super.viewDidLoad()

//    self.navigationItem.title = "Tweet Details"

//print("Inside of TweetDetailViewController: \(tweet.text)\nNumber of retweets: \(tweets.retweetd_count)\nScreenname:\(tweet.user?.screenName)")

//self.userNameLabel.text = self.tweet.user?.name ?? "Unknown"

//self.tweetTextLabel.text = self.tweet.text

// numberofTweets.text = "number of retweets: \(tweet.retweeted_count)"
//if tweet.retweeted_count < 1 {
//numberOfTweets.isHidden = true
//}
