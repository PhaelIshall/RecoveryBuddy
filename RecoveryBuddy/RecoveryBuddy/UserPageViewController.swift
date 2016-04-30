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
    
    var username: String?
    
    
    
    private (set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newSubViewController("UserProfile"),
            self.newSubViewController("Goals")]
    }()
    
    private func newSubViewController(indentifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if (indentifier == "Goals"){
            let nav = storyboard.instantiateViewControllerWithIdentifier("navGoals") as! UINavigationController
            _ = nav.topViewController   as! GoalsViewController
            return nav
        }
        else{
            let controller = storyboard.instantiateViewControllerWithIdentifier("UserProfile") as! NavigationController
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