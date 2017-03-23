//
//  API.swift
//  Twitter-Client
//
//  Created by Annie Ton-Nu on 3/21/17.
//  Copyright © 2017 Annie Ton-Nu. All rights reserved.
//

import Foundation
import Accounts
import Social


typealias AccountCallback = (ACAccount?)->()  //giving another name to a type
typealias UserCallback = (User?)->()
typealias TweetsCallback = ([Tweet]?)->()

class API {
    static let shared = API()  //now we have API.shared as a global instance
    
    var account : ACAccount?
    
    
    
    private func login(callback: @escaping AccountCallback){
        
        
        let accountStore = ACAccountStore()
        
        let accountType = accountStore.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
        
        accountStore.requestAccessToAccounts(with: accountType, options: nil) { (success, error) in
            
            if let error = error{
                print("Error: \(error.localizedDescription)")
                callback(nil)
                return
            }
            
            if success {
                if let account = accountStore.accounts(with: accountType).first as? ACAccount {
                    callback(account)
                }
                
            } else {
                print("The user did not allow access to their account")
                callback(nil)
            }
        }
    }
    
    
    //code demo in lecture today, line 55, 57
    private func getOAuthUser(callback: @escaping UserCallback){
        let url = URL(string: "https://api.twitter.com/1.1/account/verify_credentials.json")
        
        if let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, url: url, parameters: nil){
            
            
            request.account = self.account
            
            request.perform(handler: { (data, response, error) in
                
                
                if let error = error {
                    
                    print("Error : \(error)")
                    callback(nil)
                    return
                }
                
                guard let response = response else { callback(nil); return }
                guard let data = data else { callback(nil); return }
                
                
                
                
                switch response.statusCode {
                case 200...299:
                    JSONParser.userParser(data: data, callback: { (success, user) in
                        if success {
                            callback(user)
                        }
                    })
                    
                case 400...499:
                    print("Error comes from client site: \(response.statusCode)")
                    callback(nil)
                    
                case 500...599:
                    print("Error comes from server-side : \(response.statusCode)")
                    callback(nil)
                    
                default:
                    print("Error: response came back with statusCode: \(response.statusCode)")
                    callback(nil)
                }
                
            })
        }
        
    }
    
    
    private func updateTimeLine(url: String, callback: @escaping TweetsCallback){
        
        
        if let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, url: URL(string: url), parameters: nil){
            
            request.account = self.account
            
            request.perform(handler: { (data, response, error) in
                
                if let error = error {
                    print("Error: Error requesting user's home timeline - \(error.localizedDescription)")
                    callback(nil)
                    return
                }
                
                guard let response = response else { callback(nil); return }
                guard let data = data else { callback(nil); return }
                
                
                if response.statusCode >= 200 && response.statusCode < 300 {
                    JSONParser.tweetsFrom(data: data, callback: { (success, tweets) in
                        if success {
                            callback(tweets)
                        }
                    })
                    
                } else {
                    print("Something else went terrible wrong! We have a status code outside 200-299.")
                    callback(nil)
                }
                
            })
            
        }
    }
    
    
    //code demo from lecture today, line 149-156
    func getTweets(callback: @escaping TweetsCallback){
        if self.account == nil {
            
            login(callback: { (account) in
                if let account = account {
                    self.account = account
                    self.updateTimeLine( url: "https://api.twitter.com/1.1/statuses/home_timeline.json", callback: { (tweets) in callback(tweets)
                    })
                }
            })
            
        } else {
            self.updateTimeLine(url: "https://api.twitter.com/1.1/statuses/home_timeline.json", callback: { (tweets) in callback(tweets)
            })
            
        }
    }
    
    
    
    func getTweetsFor(_ user: String, callback: @escaping TweetsCallback) {
        
        let urlString = "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=\(user)"
        
        self.updateTimeLine(url: urlString) { (tweets) in callback(tweets)
        }
        
    }
    
}

