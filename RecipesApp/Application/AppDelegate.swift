import UIKit
import FirebaseCore
import GoogleSignIn


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // MARK: - Показывает только при первом запуске:
        if UserDefaults.standard.bool(forKey: "didSee") == false {
            UserDefaults.standard.set(true, forKey: "didSee")
            window?.rootViewController = WelcomeViewController()
        } else {
            window?.rootViewController = AuthorizationViewController()
        }
        window?.makeKeyAndVisible()
        return true
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool{
    return GIDSignIn.sharedInstance.handle(url)
    }
}
