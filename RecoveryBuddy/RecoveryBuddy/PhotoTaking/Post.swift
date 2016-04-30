import Foundation
import Parse
import Bond

class Post : PFObject, PFSubclassing {
    @NSManaged var imageFile: PFFile?
    @NSManaged var user: User?
    @NSManaged var content: String?
    
  var image: Observable<UIImage?> = Observable(nil)
    
    static func parseClassName() -> String {
        return "Post"
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
    
    var photoUploadTask: UIBackgroundTaskIdentifier?
    
    func uploadPost(s: String) {
        if let image = image.value {
            let imageData = UIImageJPEGRepresentation(image, 0.8)!
            let imageFile = PFFile(data: imageData)

            photoUploadTask = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler { () -> Void in
                UIApplication.sharedApplication().endBackgroundTask(self.photoUploadTask!)
            }
            imageFile!.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                UIApplication.sharedApplication().endBackgroundTask(self.photoUploadTask!)
            }

            user = User.currentUser()
            self.imageFile = imageFile
            self.content = s;
            saveInBackgroundWithBlock(nil)
        }
    }
    
    func downloadImage() {
        if (image.value == nil) {
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