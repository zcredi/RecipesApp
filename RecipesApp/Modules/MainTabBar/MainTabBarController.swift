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
    }

    func addSomeTabItems() {
        let home = UINavigationController(rootViewController: HomeViewController())
        let homeImage = UIImage(systemName: "house")
        let houseImageSelected = UIImage(systemName: "house.fill")
        home.tabBarItem = UITabBarItem(title: "Home", image: homeImage, selectedImage: houseImageSelected)

        
        let search = UINavigationController(rootViewController: SearchRecipeViewController())
        search.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        
        
        let plusImage = UIImage(systemName: "plus.circle")
        let plusImageSelected = UIImage(systemName: "plus.circle.fill")
        let createRecipe = UINavigationController(rootViewController: CreateRecipeViewController())
        createRecipe.tabBarItem = UITabBarItem(title: "Create", image: plusImage, selectedImage: plusImageSelected)
        
        
        
        let discoverImage = UIImage(systemName: "bookmark")
        let discoverImageSelected = UIImage(systemName: "bookmark.fill")
        let discover = UINavigationController(rootViewController: DiscoverViewController())
        discover.tabBarItem = UITabBarItem(title: "Discover", image: discoverImage, selectedImage: discoverImageSelected)

        
        let profileImage = UIImage(systemName: "person")
        let profileImageSelected = UIImage(systemName: "person.fill")
        let profile = UINavigationController(rootViewController: ProfileViewController())
        profile.tabBarItem = UITabBarItem(title: "Profile", image:  profileImage, selectedImage: profileImageSelected)
        
        setViewControllers([home, search, createRecipe, discover, profile], animated: true)
    
    }
}

