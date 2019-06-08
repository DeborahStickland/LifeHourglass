import UIKit
extension UIView {
    @IBInspectable var borderColor: UIColor? {
        get {
            return layer.borderColor.map { UIColor(cgColor: $0) }
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    @IBInspectable var shadowColor: UIColor? {
        get {
            return layer.shadowColor.map { UIColor(cgColor: $0) }
        }
        set {
            layer.shadowColor = newValue?.cgColor
            layer.masksToBounds = false
        }
    }
    @IBInspectable var shadowAlpha: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    func drawSideBorder(borderWidth: CGFloat, borderColor: UIColor, UI: UIView, side: borderSide) -> CALayer {
        let border = CALayer()
        border.frame = side.getFrame(UI: UI, borderWidth: borderWidth)
        border.backgroundColor = borderColor.cgColor
        return border
    }
}
enum borderSide {
    case top
    case bottom
    case left
    case right
    func getFrame(UI:UIView, borderWidth: CGFloat) -> CGRect {
        switch self {
        case .top:
            return CGRect(x: 0, y: 0, width: UI.bounds.size.width, height: borderWidth)
        case .bottom:
            return CGRect(x: 0, y: UI.bounds.maxY-borderWidth, width: UI.bounds.size.width, height: borderWidth)
        case .left:
            return CGRect(x: 0, y: 0, width: borderWidth, height: UI.bounds.size.height)
        case .right:
            return CGRect(x: UI.bounds.maxX-borderWidth, y: 0, width: borderWidth, height: UI.bounds.size.height)
        }
    }
}
