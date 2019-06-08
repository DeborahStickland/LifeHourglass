import UIKit
struct DeviceInfo {
    static func deviceIsPhone() -> Bool {
        var isIdiomPhone = true
        let currentDeveice = UIDevice.current
        if currentDeveice.userInterfaceIdiom == .phone {
            isIdiomPhone = true;
        } else if currentDeveice.userInterfaceIdiom == .pad {
            isIdiomPhone = false;
        }
        return isIdiomPhone;
    }
}
