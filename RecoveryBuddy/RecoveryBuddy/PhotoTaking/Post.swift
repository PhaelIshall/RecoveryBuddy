import Foundation
import Parse
import Bond

// 1
class Post : PFObject, PFSubclassing {
    
    // 2
    @NSManaged var imageFile: PFFile?
    @NSManaged var user: User?
    @NSManaged var content: String?
    
  var image: Observable<UIImage?> = Observable(nil)

   
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
        if let image = image.value {
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
    }
    
    func downloadImage() {
        // if image is not downloaded yet, get it
        // 1
        if (image.value == nil) {
            // 2
            imageFile?.getDataInBackgroundWithBlock { (data: NSData?, error: NSError?) -> Void in
                if let data = data {
                    let image = UIImage(data: data, scale:1.0)!
                    // 3
                    self.image.value = image
                }
            }
        }
    }

}