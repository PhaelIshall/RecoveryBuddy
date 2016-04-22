//
//  newPostViewController.swift
//  
//
//  Created by Wiem Ben Rim on 4/22/16.
//
//

import UIKit
import Parse

class newPostViewController: UIViewController, UITextViewDelegate {
    
    @IBAction func cancel(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    var photoTakingHelper: PhotoTakingHelper?

    @IBAction func Finished(sender: AnyObject) {
        post.content = postContent.text
      
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBOutlet weak var done: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "New Post"
        postContent.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var postContent: UITextView!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        postContent.text = "Write your post here"
        postContent.textColor = UIColor.lightGrayColor()
        //postContent.layer.borderColor = UIColor.lightGrayColor().CGColor
//        postContent.layer.borderWidth = 1.0;
//        postContent.layer.cornerRadius = 2.0;

        postContent.editable = true
       //postContent.becomeFirstResponder()
        
    }

    let post = Post()
    
    @IBAction func takePhoto(sender: AnyObject) {
        // instantiate photo taking class, provide callback for when photo  is selected
        
        
        photoTakingHelper = PhotoTakingHelper(viewController: self, successCallback: { (image: UIImage?) in
            print("received a callback")
            if let image = image {
                let imageData = UIImageJPEGRepresentation(image, 0.8)!
                let imageFile = PFFile(data: imageData)
                do{
                    
                    try imageFile!.save()
                }
                    
                catch{
                    
                }
                do{
                    
                    self.post.image = image
                    self.post.uploadPost(self.postContent.text)
                    
                    print ("CONTENT IS \(self.postContent.text)")
                    try self.post.save()
                }
                catch{
                    
                }
                
            }
        })
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        
        if postContent.textColor == UIColor.lightGrayColor() {
            postContent.text = ""
            postContent.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        
        if postContent.text == "" {
            
            postContent.text = "Placeholder text ..."
            postContent.textColor = UIColor.lightGrayColor()
        }
    }

    
}