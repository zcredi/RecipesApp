import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        addSomeTabItems()
        setupCustomTabBar()
    }

    func setupCustomTabBar() {
        self.tabBar.tintColor = .primary50
        self.tabBar.unselectedItemTintColor = .neutral50

        self.tabBar.backgroundColor = .systemBackground
        self.tabBar.shadowImage = UIImage()
        self.tabBar.backgroundImage = UIImage()

        let separator = CALayer()
        separator.frame = CGRect(x: 0, y: 0, width: self.tabBar.bounds.width, height: 0.5)
        separator.backgroundColor = UIColor.separator.cgColor
        self.tabBar.layer.addSublayer(separator)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(named: "redBlue")!], for: .selected)
    }

    
    func addItem(vc: UIViewController, image: UIImage?, titleImage: UIImage?, title: String) -> UIViewController {
        let item = UINavigationController(rootViewController: vc)
        
        let itemImageSelected = image?.withTintColor(UIColor(named: "redBlue")!, renderingMode: .alwaysOriginal)
        vc.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: titleImage?.withTintColor(UIColor(named: "redBlue")!, renderingMode: .alwaysOriginal))
        return item
    }
    
    func addSomeTabItems() {
        let home = addItem(vc: HomeViewController(), image: UIImage(systemName: "house"), titleImage: UIImage(systemName: "house.fill"), title: "Home")
        let search = addItem(vc: SearchRecipeViewController(), image: UIImage(systemName: "magnifyingglass"), titleImage: UIImage(systemName: "magnifyingglass"), title: "Search")
        let createRecipe = addItem(vc: CreateViewController(), image: UIImage(systemName: "plus.circle"), titleImage: UIImage(systemName: "plus.circle.fill"), title: "Create")
        let discover = addItem(vc: DiscoverViewController(), image: UIImage(systemName: "bookmark"), titleImage: UIImage(systemName: "bookmark.fill"), title: "Discover")
        let profile = addItem(vc: ProfileViewController(), image: UIImage(systemName: "person"), titleImage: UIImage(systemName: "person.fill"), title: "Profile")
        
        setViewControllers([home, search, createRecipe, discover, profile], animated: true)
    
    }
}

