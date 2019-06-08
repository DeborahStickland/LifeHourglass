import UIKit
class CustomIntroViewController: UIViewController, UIViewControllerTransitioningDelegate {
    let animator = FadeTransitionAnimator()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.transitioningDelegate = self
    }
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animator
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animator
    }
}
