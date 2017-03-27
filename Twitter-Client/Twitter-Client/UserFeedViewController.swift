//
//  UserFeedViewController.swift
//  Twitter-Client
//
//  Created by Annie Ton-Nu on 3/24/17.
//  Copyright © 2017 Annie Ton-Nu. All rights reserved.
//

import UIKit

class UserFeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var userFeedTableView: UITableView!
    
    var newUser : User!
    
    var dataSource = [Tweet](){
        didSet {
            userFeedTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("User screenname is: \(newUser.screenName)")

        self.userFeedTableView.dataSource = self
        self.userFeedTableView.delegate = self
        
        let tweetNib = UINib(nibName: "TweetNibCell", bundle: nil)
        
        self.userFeedTableView.register(tweetNib, forCellReuseIdentifier: TweetNibCell.identifier)
        
        self.userFeedTableView.estimatedRowHeight = 50
        self.userFeedTableView.rowHeight = UITableViewAutomaticDimension
        
        update()
        
    }

    
    
    func update() {
        
        API.shared.getTweetsFor(newUser.screenName) { (tweets) in
            if tweets != nil {
                OperationQueue.main.addOperation {
                    self.dataSource = tweets!
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = userFeedTableView.dequeueReusableCell(withIdentifier: TweetNibCell.identifier, for: indexPath) as! TweetNibCell
        
        let tweet = self.dataSource[indexPath.row]
            cell.tweet = tweet
        
        return cell

    }
    
}
