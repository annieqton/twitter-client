//
//  JSONParser.swift
//  Twitter-Client
//
//  Created by Annie Ton-Nu on 3/20/17.
//  Copyright © 2017 Annie Ton-Nu. All rights reserved.
//

import Foundation

typealias JSONParserCallback = (Bool,[Tweet]?)->()  //[Tweet] comes from the class Tweet on Tweet.swift .  Bool value is success flag when the data comes back.
typealias JSONUserCallback = (Bool, User?)->()


class JSONParser {
    
    //set up the static var for today because we don't have a live API call yet
    static var sampleJSONData: Data {
        
        guard let tweetJSONPath = Bundle.main.url(forResource: "tweet", withExtension: "json") else{ fatalError("Tweet.json does not exist in this bundle")}  //get a bundle, give me a main bundle singleton, and give me the url with the extension for this tweet
        
        do {
            let tweetJSONData = try Data(contentsOf: tweetJSONPath)
            return tweetJSONData
            
        } catch {
            fatalError("Failed to create data from tweetJSONPath")
        }
    }
    
    class func userParser(data: Data, callback: JSONUserCallback)-> () {  //creating a user object (User class we created) from JSON
        
        do {
            
            if let userJSON = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]{ //validate whether user is par tof the JSON data
                let user = User(json: userJSON)
                callback(true, user) // this is for the JSONUserCallback
            }
            
        } catch let error {
            
            print("Error: \(error)")
            callback(false, nil)
            
        }
        
    }
    
    
    class func tweetsFrom(data: Data, callback: JSONParserCallback){
        
        do {
            if let rootObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String : Any]]{ //this is a type method
                //[[String:Any]] is an array of dictionary
                var tweets = [Tweet]()  //() is intializing in memory that it's not nil, it's an empty array
                
                for tweetDictionary in rootObject {  //rootObject is an array of tweenDictionary
                    if let tweet = Tweet(json: tweetDictionary){
                        tweets.append(tweet)
                    }
                }
                callback(true, tweets)
            }
            
        } catch {
            print("Error Serializing JSON")
            callback(false, nil)  //return false with a nil array of tweets because there's issue with our try: unsuccesfful
        }
    }
}
