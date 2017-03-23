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
        
        self.userNameLabel.text = self.tweet.user?.name ?? "Unknown"
        
        self.tweetTextLabel.text = self.tweet.text
        
        if self.tweet.retweetedStatus {
            self.retweetStatusLabel.text = "This is a retweet"
            self.retweetStatusView.backgroundColor = UIColor.yellow
        } else {
            self.retweetStatusLabel.text = "This is not a retweet"
            self.retweetStatusView.backgroundColor = UIColor.cyan
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
