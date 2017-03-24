//
//  ProfileViewController.swift
//  Twitter-Client
//
//  Created by Annie Ton-Nu on 3/22/17.
//  Copyright © 2017 Annie Ton-Nu. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var user: User!

    
    @IBOutlet weak var name: UILabel!
 
    @IBOutlet weak var profileImageURL: UILabel!
    
    @IBOutlet weak var location: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Profile"
        
        API.shared.getUserInfo { (fetchedUser) in
            self.user = fetchedUser
            
            OperationQueue.main.addOperation {  //add this to address asynch issue.  line 33-35 were moved inside
            
                self.name.text = self.user.name
                self.profileImageURL.text = self.user.profileImageURL
                self.location.text = self.user.location
            
            }
        }
    }
}


