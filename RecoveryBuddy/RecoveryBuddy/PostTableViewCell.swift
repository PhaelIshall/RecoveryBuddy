import UIKit
import Parse


class PostTableViewCell: UITableViewCell {
    
        
    @IBOutlet weak var postImageView: UIImageView!
 
    @IBOutlet weak var username: UILabel!

    @IBOutlet weak var content: UILabel!{
        didSet{
            content.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).CGColor
            content.layer.borderWidth = 1.0
            content.layer.cornerRadius = 5
        }
    }
    
    var post: Post? {
        didSet {
            if let post = post {
                content.text = post.content
                username.text = post.user?.username
                post.image.bindTo(postImageView.bnd_image)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
