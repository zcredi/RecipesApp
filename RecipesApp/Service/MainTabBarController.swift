import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
        setupItems()
    }
    
    private func setupTabBar() {
        tabBar.backgroundColor = .neutral0
        tabBar.tintColor = .primary50
        tabBar.unselectedItemTintColor = .neutral50
    }
    
    private func setupItems() {
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        homeVC.navigationController?.navigationBar.prefersLargeTitles = true
        let home = homeVC
        let discover = DiscoverViewController()
        let notification = UIViewController()
        let profile = UIViewController()

        setViewControllers([home, discover, notification, profile], animated: true)
        
        guard let items = tabBar.items else { return }
        
        items[0].image = UIImage(named: "home")
        items[1].image = UIImage(named: "inactive")
        items[2].image = UIImage(named: "notification")
        items[3].image = UIImage(named: "profile")
    }
}
