//
//  User.swift
//  
//
//  Created by Christine Baertl on 12/04/16.
//
//

import UIKit
import Parse
import Foundation
class User : PFUser{
   // var image: Dynamic<UIImage?> = Dynamic(nil)
    var Coordinate: PFGeoPoint!{
        get{
            return self["Coordinate"]! as! PFGeoPoint
        }
        set{
            self["Coordinate"] = newValue
        }
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
    
        
    var disorderType: String{
        get{
            return self["disorderType"] as! String
        }
        set{
            self["disorderType"] = newValue
        }
    }
    
    var partner: User{
        get{
            return self["partner"] as! User
        }
        set{
            self["partner"] = newValue
        }
    }
    
    var emailVerified: Bool{
        get{
            return self["emailVerified"] as! Bool
        }
        set{
            self["emailVerified"] = newValue
        }
    }
    
    var fullname: String{
        get{
            return self["fullName"] as! String
        }
        set{
            self["fullName"] = newValue
        }
    }
    
    //do we import some date framework?
    //there is no date data type, probably
   override  var createdAt: NSDate?{
        get{
            return self["createdAt"] as? NSDate
        }
        set{
            self["createdAt"] = newValue
        }
    }
    
}



