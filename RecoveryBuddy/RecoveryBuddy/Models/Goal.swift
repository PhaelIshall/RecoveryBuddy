//
//  Goal.swift
//  
//
//  Created by Christine Baertl on 12/04/16.
//
//

import UIKit
import Parse

class Goal: PFObject, PFSubclassing {
    
    
    static func parseClassName() -> String {
        return "Goal"
    }
    
    override init () {
        super.init()
    }
    
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            // inform Parse about this subclass
            self.registerSubclass()
        }
    }

    
    var belongsTo: User{
        get{
            return self["belongsTo"] as! User
        }
        set{
            self["belongsTo"] = newValue
        }
    }
    
    var goalType: String{
        get{
            return self["goalType"] as! String
        }
        set{
            self["goalType"] = newValue
        }
    }
    
    var progress: Int{
        get{
            return self["goalType"] as! Int
        }
        set{
            self["goalType"] = newValue
        }
    }
    
    var startDate: NSDate{
        get{
            return self["startDate"] as! NSDate
        }
        set{
            self["startDate"] = newValue
        }
    }
    
    var endDate: NSDate{
        get{
            return self["endDate"] as! NSDate
        }
        set{
            self["endDate"] = newValue
        }
    }
    
   override var createdAt: NSDate{
        get{
            return self["createdAt"] as! NSDate
        }
        set{
            self["createdAt"] = newValue
        }
    }
    var details: String{
        get{
            return self["Details"] as! String
        }
        set{
            self["Details"] = newValue
        }
    }
    var goalName: String{
        get{
            return self["goalName"] as! String
        }
        set{
            self["goalName"] = newValue
        }
    }
    
    
    
}
