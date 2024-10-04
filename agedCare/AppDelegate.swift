import UIKit
import FirebaseCore
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        FirebaseApp.configure()
        let colorController = AgedMentee()
        colorController.start {url in
            DispatchQueue.main.async {
                if url.query?.contains("showAgreebutton") == true {
                    let first = UserDefaults.standard.value(forKey: "firstOpen") as? Bool ?? true
                    let mentee = MenteeHelp(url: url)
                    mentee.showButton = true
                    if first {
                        self.window = UIWindow(frame: UIScreen.main.bounds)
                        self.window!.rootViewController = mentee
                        mentee.callback =  {
                            self.startApp()
                        }
                        self.window?.makeKeyAndVisible()
                    } else {
                        self.startApp()
                    }
                } else {
                    let mentee = MenteeHelp(url: url)
                    mentee.showButton = false
                    mentee.callback = {
                        self.startApp()
                    }
                    self.window = UIWindow(frame: UIScreen.main.bounds)
                    self.window!.rootViewController = mentee
                    self.window?.makeKeyAndVisible()
                }
            }
        }
        return true
    }
    
    func startApp() {

        let navig = UINavigationController()
        let vc = TabBarClass()
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = vc
        window?.makeKeyAndVisible()
    }
}
