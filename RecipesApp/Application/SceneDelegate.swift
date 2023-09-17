import UIKit
import FirebaseCore

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        FirebaseApp.configure()
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = WelcomeViewController()
        
        // MARK: - Показывает только при первом запуске:
        
        if UserDefaults.standard.bool(forKey: "didSee") == false {
            UserDefaults.standard.set(true, forKey: "didSee")
            window?.rootViewController = WelcomeViewController()
            } else { window?.rootViewController = MainTabBarController()}
        window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }
    
}


