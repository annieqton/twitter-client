//
//  ViewFeedViewController.swift
//  Twitter-Client
//
//  Created by Annie Ton-Nu on 3/23/17.
//  Copyright © 2017 Annie Ton-Nu. All rights reserved.
//

import UIKit


//When the View Feed button is clicked, the user should segue to a 3rd view controller that will show that user's timeline. The api url is "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=" but you will need to ensure that you pass in the username as a parameter to this url.

class ViewFeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewFeedTweet = Tweet!
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == ViewFeedViewController.identifier {
            
            //when user clicks on the View Feed button, it takes user from TweetDetailViewController to ViewFeedViewController
            //display all the tweet from that user in the new view
            
            let viewFeedSelected = UIBarButtonItem.
            
            
            if let destinationController = segue.destination as? ViewFeedViewController {
                destinationController.viewFeedTweet = viewFeedTweet
                
            }
        }
        
        
        
        func updated() {
            API.shared.getTweetsFor(user.screenName) { (tweets) in
                if tweets != nil{
                    OperationQueue.main.addOperation {
                        self.dataSource = tweets!
                    }
                }
            }
        }
        
        
        
}







    
    
}



}


