//
//  DiaryViewController.swift
//  RecoveryBuddy
//
//  Created by Wiem Ben Rim on 4/6/16.
//  Copyright © 2016 Wiem Ben Rim. All rights reserved.
//

import UIKit
import Parse
import Bond

class DiaryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var photoTakingHelper: PhotoTakingHelper?
    var partner: User?
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let partnerQuery = User.query()!
        partnerQuery.whereKey("objectId", equalTo: User.currentUser()!.objectId!)
        partnerQuery.includeKey("partner")

        let postsFromPartner = Post.query()
        postsFromPartner?.whereKey("user", matchesKey: "partner", inQuery: partnerQuery)

        let postsFromThisUser = Post.query()
        postsFromThisUser!.whereKey("user", equalTo: User.currentUser()!)

        let query = PFQuery.orQueryWithSubqueries([postsFromPartner!, postsFromThisUser!])
        query.includeKey("user")
        query.orderByDescending("createdAt")

        query.findObjectsInBackgroundWithBlock { (result, error) -> Void in
            self.posts = result as? [Post] ?? []
            
            for post in self.posts {
                do{
                    let data = try post.imageFile?.getData()
                    if data != nil{
                        post.image.value = UIImage(data: data!, scale:1.0)

                    }
                }
                catch{
                    
                }   
            }
            
            self.tableview.reloadData()
        }
        
       
    }
    var posts: [Post] = []
    
   
    
    //To create a new post
    @IBAction func presenter(sender: AnyObject) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nav = storyboard.instantiateViewControllerWithIdentifier("navi") as! UINavigationController
                nav.topViewController as! newPostViewController
     let _ = storyboard.instantiateViewControllerWithIdentifier("myVCID") as UIViewController
        self.presentViewController(nav, animated: true, completion: nil)
                
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DiaryViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell")! as! PostTableViewCell
        let post = posts[indexPath.row]
        post.downloadImage()
        cell.post = post
        return cell
    }
}