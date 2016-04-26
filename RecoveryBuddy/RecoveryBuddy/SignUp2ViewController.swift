//
//  SignUp2ViewController.swift
//  RecoveryBuddy
//
//  Created by Wiem Ben Rim on 4/14/16.
//  Copyright © 2016 Wiem Ben Rim. All rights reserved.
//

import Parse
import UIKit

class SignUp2ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    var user: User? 
    var profilePic: NSData?
    
    @IBAction func signUp(sender: AnyObject) {
        print(self.user)
        
        user?.disorderType = myLabel.text!
        let imageFile = PFFile(data: profilePic!)
        do{
            
           try imageFile!.save()
            user?.profilePic = imageFile!
        }
        catch{
            
        }
        
        print(user?.disorderType)
        
        user!.signUpInBackgroundWithBlock{ (succeeded: Bool, error: NSError?) -> Void in
            
            
            if let error = error {
                _ = error.userInfo["error"] as? NSString
                // Show the errorString somewhere and let the user try again.
                
                print("user not made")
            } else {
                // Hooray! Let them use the app now.
            }
        }
        
        performSegueWithIdentifier("finishSignUp", sender: self)
        print("kljkgijl")
    }

    @IBOutlet weak var myLabel: UILabel!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
      
    }
    

    @IBOutlet weak var myPicker: UIPickerView!
    
    //MARK: DATA SOURCE + DELEGATES
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    let pickerData = [" Anorexia Nervosa","Bulimia Nervosa","Binge Eating Disorder","Eating Disorder NOS","Night Eating Syndrome","Orthorexia","Pica"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myLabel.text = "DisorderType";
        myPicker.dataSource = self
        myPicker.delegate = self
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let titleData = pickerData[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
        pickerLabel.attributedText = myTitle
        let hue = CGFloat(row)/CGFloat(pickerData.count)
        pickerLabel.backgroundColor = UIColor(hue: hue, saturation: 1.0, brightness:1.0, alpha: 1.0)
        pickerLabel.textAlignment = .Center
        return pickerLabel
       
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        myLabel.text = pickerData[row]
        //color  and center the label's background
      
    }
    
  
    
    // MARK: - Navigation
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       if (segue.identifier == "finishSignUp"){
//            segue.destinationViewController as! UITabBarController
//           
    }
        
       
    }
    
    

}
