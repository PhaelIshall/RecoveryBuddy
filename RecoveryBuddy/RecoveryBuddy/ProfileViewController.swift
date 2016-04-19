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
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var disorderType: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var emailAddress: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var picture: UIImageView!
    
    
    var usernameOfPartner: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
    picture.layer.cornerRadius = picture.frame.size.width/2;
    picture.layer.borderWidth = 1;
    picture.clipsToBounds = true;
    usernameOfPartner = User.currentUser()!["partner"].username
    partner.text = usernameOfPartner
        //age.text = "erfds"
        //age.text = "\(User.currentUser()!.age) years of age"
        //disorderType.text = PFUser.currentUser()!["disorderType"] as! String
        //name.text = User.currentUser()!.fullname
        //emailAddress.text = "frwedawfe \(User.currentUser()?.email)"
    username.text = User.currentUser()?.username
        

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
