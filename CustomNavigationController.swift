import UIKit
class CustomNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.tintColor = UIColor.white
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
}
