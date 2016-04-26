import UIKit
import Parse


class PartnerSelectedPageViewController: UIPageViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                direction: .Forward,
                animated: true,
                completion: nil)
        }
    }
    
    private (set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newColoredViewController("Profile"),
            self.newColoredViewController("Goals")]
    }()
    
    private func newColoredViewController(color: String) -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
 if (color == "Goals"){
            
            let nav = storyboard.instantiateViewControllerWithIdentifier("nav\(color)") as! UINavigationController
            let controller = nav.topViewController   as! GoalsViewController
            controller.partnerGoals = true
             return nav 
        }
        else{
            
            let nav = storyboard.instantiateViewControllerWithIdentifier("nav\(color)") as! UINavigationController
          let controller = nav.topViewController as! PartnerProfileViewController
    
    
            let partnerQuery = User.query()
            partnerQuery!.whereKey("objectId", equalTo: User.currentUser()!.objectId!)
            partnerQuery?.includeKey("partner")
    
            var partnerSelected: User?
    
    var partnerExists = false;
    
    partnerQuery?.findObjectsInBackgroundWithBlock({ (p, error) -> Void in
        if let partner = p as? [User] {
            for entry in partner{
                if (entry != User.currentUser()){
                    partnerExists = true;
                    partnerSelected = entry
                    do{
                        controller.partnerPic.layer.cornerRadius = controller.partnerPic.frame.size.width/2;
                        controller.partnerPic.layer.borderWidth = 1;
                        controller.partnerPic.clipsToBounds = true;
                        
                     try   controller.partnerPic.image = UIImage(data: (partnerSelected?.partner!.profilePic.getData())!)
                        controller.username.text = partnerSelected?.username
                        controller.fullname.text = partnerSelected?.fullname
                        controller.age.text = "\(partnerSelected!.age)"
                         controller.email.text = partnerSelected?.email
                    }
                    catch{
                        
                    }
                    
                    
                }
              
            }
        }
        
    })
    
             return nav
        }
     
       
    }
    
}

// MARK: UIPageViewControllerDataSource

extension PartnerSelectedPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController,
        viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
            guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else {
                return nil
            }
            
            let previousIndex = viewControllerIndex - 1
            
            guard previousIndex >= 0 else {
                return nil
            }
            
            guard orderedViewControllers.count > previousIndex else {
                return nil
            }
            
            return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(pageViewController: UIPageViewController,
        viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
            guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else {
                return nil
            }
            
            let nextIndex = viewControllerIndex + 1
            let orderedViewControllersCount = orderedViewControllers.count
            
            guard orderedViewControllersCount != nextIndex else {
                return nil
            }
            
            guard orderedViewControllersCount > nextIndex else {
                return nil
            }
            
            return orderedViewControllers[nextIndex]
    }
    
}