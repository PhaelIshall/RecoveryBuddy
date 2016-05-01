//
//  NewGoalViewController.swift
//  RecoveryBuddy
//
//  Created by Wiem Ben Rim on 4/14/16.
//  Copyright © 2016 Wiem Ben Rim. All rights reserved.
//

import UIKit
import Parse

class NewGoalViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate, UITextFieldDelegate {
    
    var details: String!
    var goaltype = -1;
    var pickerDataSource = ["Meal plan", "Intuitive eating", "Exercise", "Not exercise", "Custom"];
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var goalType: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var addDetails: UITextView!{
        didSet{
            details = addDetails.text
        }
    }
    
    

    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
   
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.delegate = self
        pickerView.dataSource = self;
        pickerView.delegate = self;
        addDetails.delegate = self
        addDetails.text = "Please add details to your goal"
        addDetails.textColor = UIColor.lightGrayColor()
        let tapGestureReconizer = UITapGestureRecognizer(target: self, action: "tap:")
        view.addGestureRecognizer(tapGestureReconizer)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "continueToGoal"){
            if (addDetails.text != "" && name.text != ""){
                let nextGoalController = segue.destinationViewController as! NewGoalViewController2
                nextGoalController.details = addDetails.text
                nextGoalController.goalType = goaltype
                nextGoalController.name = name.text!
            
            }
            else{
                let alertController = UIAlertController(title: "Invalid fields", message: "Please make sure to fill in a name and some details: some incentive that goes back to why you chose this goal", preferredStyle: .Alert)
                let callAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertController.addAction(callAction)
                self.presentViewController(alertController, animated: true, completion: nil)
            }
        }
    }
    
    
   //MARK: PICKERVIEW AND TEXTVIEW DELEGATE FUNCTIONS
    func textViewDidBeginEditing(textView: UITextView) {
        
        if addDetails.textColor == UIColor.lightGrayColor() {
            addDetails.text = ""
            addDetails.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        
        if addDetails.text == "" {
            addDetails.text = "Placeholder text ..."
            addDetails.textColor = UIColor.lightGrayColor()
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
   
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        switch row{
        case 0: goaltype = 0
        case 1: goaltype = 1
        case 2: goaltype = 2
        case 3: goaltype = 3
        case 4: goaltype = 4
        default : goaltype = 0
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    
    func textViewShouldReturn(textField: UITextView) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    
    func tap(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    

}