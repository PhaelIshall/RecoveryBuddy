import Foundation
import Parse

// 1
class ParseHelper {
    
    // 2
    static func timelineRequestForCurrentUser(completionBlock: PFArrayResultBlock) {
        //Need to make it from both sides but for now okay
        let partnerQuery = PFQuery(className: "Partner")
        partnerQuery.whereKey("fromUser", equalTo: User.currentUser()!)
        
        let postsFromPartner = Post.query()
        //postsFromPartner?.whereKey("user", equalTo: User.currentUser()!)
        postsFromPartner?.whereKey("user", matchesKey: "toUser", inQuery: partnerQuery)
        
        // 3
        let postsFromThisUser = Post.query()
        postsFromThisUser!.whereKey("user", equalTo: User.currentUser()!)
        
        // 4
        let query = PFQuery.orQueryWithSubqueries([postsFromPartner!, postsFromThisUser!])
        // 5
        query.includeKey("user")
        // 6
        query.orderByDescending("createdAt")
        
      //  query.findObjectsInBackgroundWithBlock(completionBlock)
        
    }
    
}