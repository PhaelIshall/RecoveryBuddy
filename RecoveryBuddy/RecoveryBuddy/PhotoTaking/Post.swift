import Foundation
import Parse


// 1
class Post : PFObject, PFSubclassing {
    
    // 2
    @NSManaged var imageFile: PFFile?
    @NSManaged var user: User?
    @NSManaged var content: String?
    
   var image: UIImage?

   
    //MARK: PFSubclassing Protocol
    
    // 3
    static func parseClassName() -> String {
        return "Post"
    }
    
    // 4
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
    
    var photoUploadTask: UIBackgroundTaskIdentifier?
    
    func uploadPost(s: String) {
        if let image = image {
            let imageData = UIImageJPEGRepresentation(image, 0.8)!
            let imageFile = PFFile(data: imageData)
            
            // 1
            photoUploadTask = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler { () -> Void in
                UIApplication.sharedApplication().endBackgroundTask(self.photoUploadTask!)
            }
            
            // 2
            imageFile!.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                // 3
                UIApplication.sharedApplication().endBackgroundTask(self.photoUploadTask!)
            }
            
            // any uploaded post should be associated with the current user
            user = User.currentUser()
            self.imageFile = imageFile
            self.content = s;
            saveInBackgroundWithBlock(nil)
        }
    }}