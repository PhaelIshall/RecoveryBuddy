//
//  DiaryViewController.swift
//  RecoveryBuddy
//
//  Created by Wiem Ben Rim on 4/6/16.
//  Copyright © 2016 Wiem Ben Rim. All rights reserved.
//

import UIKit
import Parse

class DiaryViewController: UIViewController {
var photoTakingHelper: PhotoTakingHelper?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var partner: User?
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //Need to make it from both sides but for now okay
        let partnerQuery = PFQuery(className: "Partner")
        partnerQuery.whereKey("fromUser", equalTo: User.currentUser()!)
 
        let postsFromPartner = Post.query()
        //postsFromPartner?.whereKey("user", equalTo: User.currentUser()!)
        postsFromPartner?.whereKey("user", matchesKey: "toUser", inQuery: partnerQuery)
        
        // 3
        let postsFromThisUser = Post.query()
        postsFromThisUser!.whereKey("user", equalTo: User.currentUser()!)
        
        // 4
        let query = PFQuery.orQueryWithSubqueries([postsFromPartner!, postsFromThisUser!])
        // 5
        query.includeKey("user")
        // 6
        query.orderByDescending("createdAt")
        
        // 7
    
        
        query.findObjectsInBackgroundWithBlock { (result, error) -> Void in
            self.posts = result as? [Post] ?? []
            // 9
            
            for post in self.posts {
                // 2
                do{
                    let data = try post.imageFile?.getData()
                    if data != nil{
                        post.image = UIImage(data: data!, scale:1.0)

                    }
                    
//                   post.user = User.currentUser()
                }
                catch{
                    
                }
                // 3
                
            }
            
            self.tableview.reloadData()
        }
        
       
    }
    var posts: [Post] = []
    
   
    @IBAction func presenter(sender: AnyObject) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nav = storyboard.instantiateViewControllerWithIdentifier("navi") as! UINavigationController
                nav.topViewController as! newPostViewController
     let vc: UIViewController = storyboard.instantiateViewControllerWithIdentifier("myVCID") as UIViewController
        self.presentViewController(nav, animated: true, completion: nil)
                
        
    }
//    @IBAction func takePhoto(sender: AnyObject) {
//        // instantiate photo taking class, provide callback for when photo  is selected
//        
//        
//        photoTakingHelper = PhotoTakingHelper(viewController: self, successCallback: { (image: UIImage?) in
//            print("received a callback")
//            if let image = image {
//                let imageData = UIImageJPEGRepresentation(image, 0.8)!
//                let imageFile = PFFile(data: imageData)
//                do{
//                   
//                    try imageFile!.save()
//                }
//               
//                catch{
//                    
//                }
//                do{
//                    let post = Post()
//                    post.image = image
//                    post.uploadPost()
//                    try post.save()
//                }
//                catch{
//                    
//                }
//                
//            }
//        })
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension DiaryViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 1
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 2
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell")! as! PostTableViewCell
        cell.postImageView.image = posts[indexPath.row].image
        //cell.textLabel!.text = "Post"
        cell.username.text = posts[indexPath.row].user?.username
        cell.content.text = posts[indexPath.row].content
        
        return cell
    }
    
}