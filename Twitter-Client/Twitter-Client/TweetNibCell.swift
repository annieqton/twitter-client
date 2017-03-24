//
//  TweetNibCell.swift
//  Twitter-Client
//
//  Created by Annie Ton-Nu on 3/23/17.
//  Copyright © 2017 Annie Ton-Nu. All rights reserved.
//

//lecture code demo

import UIKit

class TweetNibCell: UITableViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!

    var tweet: Tweet! {
        didSet {
            self.tweetLabel.text = tweet.text
            self.usernameLabel.text = tweet.user?.name ?? "Unknown User"  //using nil coelescing to show "unknown user" instead of nil when there's no user
            
            if let user = tweet.user {
            
                UIImage.fetchImageWith(user.profileImageURL) { (image) in
                    self.userImageView.image = image
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
