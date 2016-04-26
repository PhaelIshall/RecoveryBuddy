import UIKit

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.barStyle = UIBarStyle.Black
        self.navigationBar.translucent = true
        self.navigationBar.barTintColor = UIColor(red: 126/255, green: 178/255, blue: 70/255, alpha: 0.6)
        self.navigationBar.tintColor = UIColor.whiteColor()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
