//
//  HomeTimelineViewController.swift
//  Twitter-Client
//
//  Created by Annie Ton-Nu on 3/20/17.
//  Copyright © 2017 Annie Ton-Nu. All rights reserved.
//

import UIKit


class HomeTimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {   //HomeTimelineViewController is subclass of UIViewController
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func ProfileButtonPressed(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "ProfileViewControllerSegue", sender: sender)
        
        
        
    }
    
    
    var dataSource = [Tweet](){
        didSet {
            tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "My Timeline"
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        let tweetNib = UINib(nibName: "TweetNibCell", bundle: nil)  //nil means bundle.main here
        
        self.tableView.register(tweetNib, forCellReuseIdentifier: TweetNibCell.identifier)
        
        self.tableView.estimatedRowHeight = 50
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        update()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == TweetDetailViewController.identifier {
            
                let selectedIndex = tableView.indexPathForSelectedRow!.row
                let selectedTweet = dataSource[selectedIndex]
                
            if let destinationController = segue.destination as? TweetDetailViewController {
                destinationController.tweet = selectedTweet
                
            }
        }
        
        
    }
    

    
    func update() {
        
        self.activityIndicator.startAnimating()
        
        API.shared.getTweets { (tweets) in
            if tweets != nil{
                OperationQueue.main.addOperation {
                    self.dataSource = tweets!
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TweetNibCell.identifier, for: indexPath) as! TweetNibCell
        
        let tweet = self.dataSource[indexPath.row]
            cell.tweet = tweet
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {  //if click on the tweet, this will lead to another screen to show the user, image, and tweet details
        
        self.performSegue(withIdentifier: TweetDetailViewController.identifier, sender: nil)
        
        
    }
    
}
