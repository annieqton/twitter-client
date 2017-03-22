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
    
        var dataSource = [Tweet]()

    
    override func viewDidLoad() {
        super.viewDidLoad()  // in order to overide a subclass, you need to make a call to super
        
         //Lab 6
        //Assign ViewController.swift to be the dataSource of tableView programmatically.
        //Assign ViewController.swift to be the delegate of tableView and implement the tableView(_ tableView:, didSelectRowAt indexPath:) method. When a user clicks on a specific cell, print() the indexPath.row to the console.
        
        // everytime you use a tableview you need to set the datasource and the delegate
        self.tableView.dataSource = self
        self.tableView.delegate = self  //homeview

        JSONParser.tweetsFrom(data: JSONParser.sampleJSONData) { (success, tweets) in
            
            if(success){
                guard let tweets = tweets else { fatalError("Tweets came back nil") }
                
                for tweet in tweets{
                    dataSource.append(tweet)
                    
                    //Lab 6: Assign ViewController.swift to be the delegate of tableView and implement the tableView(_ tableView:, didSelectRowAt indexPath:) method. When a user clicks on a specific cell, print() the indexPath.row to the console.
                }
            }
    
        }

    }
    
    
    //Lab 6: Assign ViewController.swift to be the delegate of tableView and implement the tableView(_ tableView:, didSelectRowAt indexPath:) method. When a user clicks on a specific cell, print() the indexPath.row to the console.
    
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

