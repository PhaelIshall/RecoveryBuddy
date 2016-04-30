//
//  ProfileViewController.swift
//  RecoveryBuddy
//
//  Created by Wiem Ben Rim on 4/19/16.
//  Copyright © 2016 Wiem Ben Rim. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

    @IBOutlet weak var partner: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var disorderTypeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailAddressLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var picture: UIImageView!
    
    
    var usernameOfPartner, age, disorderType, email, fullname, username: String?
    var imageData: NSData?
    override func viewDidLoad() {
        super.viewDidLoad()
        
    picture.layer.cornerRadius = picture.frame.size.width/2;
    picture.layer.borderWidth = 1;
    picture.clipsToBounds = true;
        
        
        if let _ = usernameOfPartner{
            
             partner.text = usernameOfPartner
        }
    
        ageLabel.text = "\(age!) years of age"
        disorderTypeLabel.text = disorderType
        nameLabel.text = fullname
        emailAddressLabel.text = "\(email!)"
        usernameLabel.text = username
        picture.image = UIImage(data: imageData!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
