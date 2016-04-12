//
//  CalViewController.swift
//  RecoveryBuddy
//
//  Created by Wiem Ben Rim on 3/22/16.
//  Copyright (c) 2016 Wiem Ben Rim. All rights reserved.
//
import MBCalendarKit
import UIKit

class CalViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    var pickerDataSource = ["Meal plan", "Intuitive eating", "Exercise", "Not exercise", "Custom"];
    
    @IBOutlet weak var pickerView: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.pickerView.dataSource = self;
//        self.pickerView.delegate = self;
//    
        let calendar = CKCalendarView();
//        calendar.delegate = self;
//        calendar.setDataSource = self;
        let spacerView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        self.view.addSubview(spacerView)
        self.view.addSubview(calendar)
        
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
           
        }
        else if(row == 1)
        {
           
        }
        else if(row == 2)
        {
          
        }
        else
        {
            
        }
    }
}