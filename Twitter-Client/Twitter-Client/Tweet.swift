//
//  Tweet.swift
//  Twitter-Client
//
//  Created by Annie Ton-Nu on 3/20/17.
//  Copyright © 2017 Annie Ton-Nu. All rights reserved.
//

import Foundation

class Tweet{
    let text: String
    let id: String

    var user: User?  //is a var so it can be changed at a later time

    //failable initializer (using optionals) that can take ni;
    init?(json: [String: Any]) {

        //since we set it as Any type above, we have to type cast it as string, i.e.   as? String
        if let text = json["text"] as? String, let id = json["id_str"] as? String {

            self.text = text
            self.id = id

            if let userDictionary = json["user"] as? [String: Any] {  //if this fails then we
                self.user = User(json: userDictionary)               // have a nil user with a valid tweet
            }

        } else {
            return nil
        }
    }

}
