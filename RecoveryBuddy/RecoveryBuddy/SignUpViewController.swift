//
//  SignUpViewController.swift
//  RecoveryBuddy
//
//  Created by Wiem Ben Rim on 3/21/16.
//  Copyright (c) 2016 Wiem Ben Rim. All rights reserved.
//

import UIKit

import Firebase

class SignUpViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    var pickerDataSource = ["Eating Disorder NOS", "Anorexia Nervosa", "Bulimia Nervosa", "Binge Eating Disorder"];

    @IBOutlet weak var pickerView: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ref = Firebase(url:"https://recoverybuddy.firebaseio.com/")

        let alanisawesome = ["full_name": "Alan Turing", "date_of_birth": "June 23, 1912"]
        let gracehop = ["full_name": "Grace Hopper", "date_of_birth": "December 9, 1906"]
        
        let usersRef = ref.childByAppendingPath("users")
        
        let users = ["alanisawesome": alanisawesome, "gracehop": gracehop]
        usersRef.setValue(users)
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerDataSource[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if(row == 0)
        {
            self.view.backgroundColor = UIColor.whiteColor();
        }
        else if(row == 1)
        {
            self.view.backgroundColor = UIColor.redColor();
        }
        else if(row == 2)
        {
            self.view.backgroundColor =  UIColor.greenColor();
        }
        else
        {
            self.view.backgroundColor = UIColor.blueColor();
        }
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
