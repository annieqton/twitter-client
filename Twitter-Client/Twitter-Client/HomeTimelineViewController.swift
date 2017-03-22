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
    
    var dataSource = [Tweet](){
        didSet {
            tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
//        JSONParser.tweetsFrom(data: JSONParser.sampleJSONData) { (success, tweets) in
//            
//            if(success){
//                guard let tweets = tweets else { fatalError("Tweets came back nil") }
//                
//                for tweet in tweets{
//                    dataSource.append(tweet)
//                   
//                }
//            }
//            
//        }
        update()
    }
    
    func update() {
        API.shared.getTweets { (tweets) in
            if tweets != nil{
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
        
        let tweetToDisplay = dataSource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath)
        
        cell.textLabel?.text = tweetToDisplay.text
        cell.detailTextLabel?.text = tweetToDisplay.user?.name
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print("\(indexPath.row)")
        
    }
    
}
