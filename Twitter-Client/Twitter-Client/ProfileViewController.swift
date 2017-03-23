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
        
        //still need code here
        //if user log in through getOAuthUser is true, then display the user information. else display error message
        
        
        //display user info
        self.name.text = self.name.text
        self.profileImageURL.text = self.profileImageURL.text
        self.location.text = self.location.text

    }
}


