import UIKit
enum EWDatePickerPresentAnimateType {
    case present
    case dismiss
}
class EWDatePickerPresentAnimated: NSObject,UIViewControllerAnimatedTransitioning {
    var type: EWDatePickerPresentAnimateType = .present
    init(type: EWDatePickerPresentAnimateType) {
        self.type = type
    }
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch type {
        case .present:
            let toVC : EWDatePickerViewController = transitionContext.viewController(forKey: .to) as! EWDatePickerViewController
            let toView = toVC.view
            let containerView = transitionContext.containerView
            containerView.addSubview(toView!)
            toVC.containV.transform = CGAffineTransform(translationX: 0, y: (toVC.containV.frame.height))
            UIView.animate(withDuration: 0.25, animations: {
                toVC.backgroundView.alpha = 1.0
                toVC.containV.transform =  CGAffineTransform(translationX: 0, y: -10)
            }) { (finished) in
                UIView.animate(withDuration: 0.2, animations: {
                    toVC.containV.transform = CGAffineTransform.identity
                }, completion: { (finished) in
                    transitionContext.completeTransition(true)
                })
            }
        case .dismiss:
            let toVC : EWDatePickerViewController = transitionContext.viewController(forKey: .from) as! EWDatePickerViewController
            UIView.animate(withDuration: 0.25, animations: {
                toVC.backgroundView.alpha = 0.0
                toVC.containV.transform =  CGAffineTransform(translationX: 0, y: (toVC.containV.frame.height))
            }) { (finished) in
                transitionContext.completeTransition(true)
            }
        }
    }
}
