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

    func addSomeTabItems() {
        let home = UINavigationController(rootViewController: HomeViewController())
        let homeImage = UIImage(systemName: "house")
        let houseImageSelected = UIImage(systemName: "house.fill")?.withTintColor(UIColor(named: "redBlue")!, renderingMode: .alwaysOriginal)
        home.tabBarItem = UITabBarItem(title: "Home", image: homeImage, selectedImage: houseImageSelected)

        
        let search = UINavigationController(rootViewController: SearchRecipeViewController())
        let normalImage = UIImage(systemName: "magnifyingglass")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        let selectedImage = UIImage(systemName: "magnifyingglass")?.withTintColor(UIColor(named: "redBlue")!, renderingMode: .alwaysOriginal)

        search.tabBarItem = UITabBarItem(title: "Search", image: normalImage, selectedImage: selectedImage)
        
        
        
        let plusImage = UIImage(systemName: "plus.circle")
        let plusImageSelected = UIImage(systemName: "plus.circle.fill")?.withTintColor(UIColor(named: "redBlue")!, renderingMode: .alwaysOriginal)
        let createRecipe = UINavigationController(rootViewController: CreateViewController())
        createRecipe.tabBarItem = UITabBarItem(title: "Create", image: plusImage, selectedImage: plusImageSelected)
        
        
        
        let discoverImage = UIImage(systemName: "bookmark")
        let discoverImageSelected = UIImage(systemName: "bookmark.fill")?.withTintColor(UIColor(named: "redBlue")!, renderingMode: .alwaysOriginal)
        let discover = UINavigationController(rootViewController: DiscoverViewController())
        discover.tabBarItem = UITabBarItem(title: "Discover", image: discoverImage, selectedImage: discoverImageSelected)

        
        let profileImage = UIImage(systemName: "person")
        let profileImageSelected = UIImage(systemName: "person.fill")?.withTintColor(UIColor(named: "redBlue")!, renderingMode: .alwaysOriginal)
        let profile = UINavigationController(rootViewController: ProfileViewController())
        profile.tabBarItem = UITabBarItem(title: "Profile", image:  profileImage, selectedImage: profileImageSelected)
        
        setViewControllers([home, search, createRecipe, discover, profile], animated: true)
    
    }
}

