import Foundation
import UIKit
typealias CompletionHandler = (()->Void)
class FadeTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    var isPresented: Bool = false
    var dismissFinishHandler: CompletionHandler? = nil
    var presentFinishHandler: CompletionHandler? = nil
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.7
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        switch isPresented{
        case true:
            dismiss(transitionContext: transitionContext, toView: toVC!.view, fromView: fromVC!.view, completion: dismissFinishHandler)
        case false:
            present(transitionContext: transitionContext, toView: toVC!.view, fromView: fromVC!.view, completion: presentFinishHandler)
        }
    }
    func present(transitionContext: UIViewControllerContextTransitioning, toView: UIView, fromView: UIView, completion: CompletionHandler?) {
        let container = transitionContext.containerView
        container.insertSubview(toView, belowSubview: fromView)
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: .curveEaseInOut, animations: {
            fromView.alpha = 0.0
        }) { (finished) in
            transitionContext.completeTransition(true)
            completion?()
        }
    }
    func dismiss(transitionContext: UIViewControllerContextTransitioning, toView: UIView, fromView: UIView, completion:  CompletionHandler?) {
        let container = transitionContext.containerView
        container.insertSubview(toView, aboveSubview: fromView)
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: .curveEaseInOut, animations: {
            toView.alpha = 0.0
        }) { (finished) in
            transitionContext.completeTransition(true)
            completion?()
        }
    }
}
