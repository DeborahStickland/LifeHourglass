import UIKit
import CoreData
extension Date {
    static func getTimes() -> [String:Any] {
        var dictionary = [String:Any]()
        let now = Date()
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy/MM"
        dictionary["yearAndMonth"] = dformatter.string(from: now as Date)
        dformatter.dateFormat = "dd"
        dictionary["day"] = dformatter.string(from: now as Date)
        dformatter.dateFormat = "HH:mm"
        dictionary["time"] = dformatter.string(from: now as Date)
        let timesInterval : TimeInterval = now.timeIntervalSince1970
        let timeStamp = Int64(timesInterval)
        dictionary["timestamp"] = timeStamp
        let days = Int(timesInterval/86400)
        let weekDay = (days - 3)%7
        dictionary["dayOfWeek"] = Int16(weekDay)
        return dictionary
    }
}
