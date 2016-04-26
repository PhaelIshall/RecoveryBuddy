import UIKit

class UserPageViewController: UIPageViewController {
    
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
        return [self.newColoredViewController("UserProfile"),
            self.newColoredViewController("Goals")]
    }()
    
    private func newColoredViewController(color: String) -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        
        
        if (color == "Goals"){
            
            let nav = storyboard.instantiateViewControllerWithIdentifier("navGoals") as! UINavigationController
            let controller = nav.topViewController   as! GoalsViewController
//            controller.partnerGoals = true
            return nav
        }
        else{
            
            let controller = storyboard.instantiateViewControllerWithIdentifier("UserProfile")
            
            return controller
        }
        
        
    }
    
}

// MARK: UserPageViewControllerDataSource

extension UserPageViewController: UIPageViewControllerDataSource {
    
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