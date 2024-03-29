import UIKit
extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
    static func navColor() -> UIColor {
        return UIColor(r: 73, g: 73 , b: 73)
    }
}
