import UIKit

class TabBarClass: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabs()
        self.selectedIndex = 0
        self.tabBar.barTintColor = AgedColor.bgColor
        self.tabBar.tintColor = AgedColor.blue
        self.tabBar.backgroundColor = AgedColor.bgColor
        self.tabBar.unselectedItemTintColor = .gray
        self.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    
    private func setupTabs(){
        let home = self.createNav(with: "My mentees", image: UIImage(systemName: "list.bullet.rectangle") ?? .add, vc: ViewController())
        let mail = self.createNav(with: "Help", image: UIImage(systemName: "questionmark.app") ?? .add, vc: MailViewController())
       
        self.setViewControllers([home, mail], animated: true)
    }
    
    private func createNav(with title: String, image: UIImage, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem .title = title
        nav.tabBarItem.image = image
        nav.viewControllers.first?.navigationItem.title = title
       return nav
    }

}
