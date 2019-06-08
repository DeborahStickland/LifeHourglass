import Foundation
import UIKit
struct ScreenInfo {
    static let Frame = UIScreen.main.bounds
    static let Height = Frame.height
    static let Width = Frame.width
    static let navigationHeight:CGFloat = navBarHeight()
    static func isIphoneX() -> Bool {
        return UIScreen.main.bounds.equalTo(CGRect(x: 0, y: 0, width: 375, height: 812))
    }
    static private func navBarHeight() -> CGFloat {
        return isIphoneX() ? 88 : 64;
    }
}
extension UIColor {
    class func colorWithRGBA(r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
}
struct dateTools {
    static var currentDateCom: DateComponents = Calendar.current.dateComponents([.year, .month, .day],   from: Date())
    static func dataNow() -> String{
        let date = Date.init()
        let timeFormatter = DateFormatter.init()
        timeFormatter.dateFormat="yyyyMMddHHmmss"
        return timeFormatter.string(from: date)
    }
    static func stringConvertDate(string:String, dateFormat:String="yyyy-MM-dd HH:mm:ss") -> Date? {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: string)
        return date
    }
    static  func solarToLunar(year: Int, month: Int, day: Int) -> String {
        let solarCalendar = Calendar.init(identifier: .gregorian)
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = 12
        components.minute = 0
        components.second = 0
        components.timeZone = TimeZone.init(secondsFromGMT: 60 * 60 * 8)
        let solarDate = solarCalendar.date(from: components)
        let lunarCalendar = Calendar.init(identifier: .chinese)
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.calendar = lunarCalendar
        return formatter.string(from: solarDate!)
    }
    static  func calcunateCuntdownDays(birthday: String) -> Int {
        let defaultDateFormatter = DateFormatter()
        defaultDateFormatter.locale = Locale.current
        var countDown = 0
        let currentDay = Date()
        defaultDateFormatter.dateFormat = "yyyy"
        let currentYear = defaultDateFormatter.string(from: currentDay)
        var newBirthdayString = birthday
        newBirthdayString.replaceSubrange(newBirthdayString.startIndex ..< newBirthdayString.index(newBirthdayString.startIndex, offsetBy: 4), with: currentYear)
        defaultDateFormatter.dateFormat = "yyyy-MM-dd"
        let birthDay = defaultDateFormatter.date(from: newBirthdayString)
        if let birthDay = birthDay {
            if birthDay <= currentDay {
                let yearsToAdd = 1
                var newDateComponent = DateComponents()
                newDateComponent.year = yearsToAdd
                let newBirthDay = Calendar.current.date(byAdding: newDateComponent, to: birthDay)
                countDown = compare2Date(FromDate: currentDay, ToDate: newBirthDay!)
            }else {
                countDown = compare2Date(FromDate: currentDay, ToDate: birthDay)
            }
        }
        return countDown + 2
    }
    static  func compare2Date(FromDate: Date, ToDate: Date) -> Int {
        var result = 0
        let interval = ToDate.timeIntervalSince(FromDate)
        result = Int(round(interval / 86400.0))
        return result - 1
    }
    static func isToday(date:Date)->Bool{
       return Calendar.current.isDate(date, inSameDayAs: Date())
    }
    static func isTodayInYear(m:Int,d:Int) ->Bool{
        if(currentDateCom.month == m && currentDateCom.day == d ){
            return true
        }
        return false
    }
}
extension UIView {
    public enum ShakeDirection: Int {
        case horizontal  
        case vertical  
    }
    public func shake(direction: ShakeDirection = .horizontal, times: Int = 5,
                      interval: TimeInterval = 0.1, delta: CGFloat = 2,
                      completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: interval, animations: { () -> Void in
            switch direction {
            case .horizontal:
                self.layer.setAffineTransform( CGAffineTransform(translationX: delta, y: 0))
                break
            case .vertical:
                self.layer.setAffineTransform( CGAffineTransform(translationX: 0, y: delta))
                break
            }
        }) { (complete) -> Void in
            if (times == 0) {
                UIView.animate(withDuration: interval, animations: { () -> Void in
                    self.layer.setAffineTransform(CGAffineTransform.identity)
                }, completion: { (complete) -> Void in
                    completion?()
                })
            }
            else {
                self.shake(direction: direction, times: times - 1,  interval: interval,
                           delta: delta * -1, completion:completion)
            }
        }
    }
}
