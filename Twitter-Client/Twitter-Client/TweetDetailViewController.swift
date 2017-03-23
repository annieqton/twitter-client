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
