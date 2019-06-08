import Foundation
import UserNotifications
struct myNotifications {
    func deleteMyNotification(with indentifer:String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [indentifer])
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [indentifer])
    }
    func addMyNotification(with data:NSMutableDictionary) {
        let dateFormatter = DateFormatter.init()
            dateFormatter.dateFormat = "yyyy-MM-dd"
        let content = UNMutableNotificationContent()
        if  let isRemind = data.value(forKey: "isRemind") as? String,
            let time :String = data.value(forKey: "time") as? String ,
            let title:String = data.value(forKey: "title")as? String ,
            let gift:String = data.value(forKey: "isNeedGift")as? String,
            var dateTime = dateFormatter.date(from: time),
            let remindType:String = data.value(forKey: "remindType") as? String,
            let dayType = data.value(forKey: "dayType") as? String {
            if(isRemind == "false") {
                return
            }
            var timeDateCom: DateComponents = Calendar.current.dateComponents([.year, .month, .day],   from:dateTime )
            if dayType == NSLocalizedString("Anniversary", comment: "") {
                let today = Date()
                let days = dateTools.compare2Date(FromDate: dateTime, ToDate:today)
                let year :Int = days / 365
                if  let timeDay = timeDateCom.day ,let timeMonth = timeDateCom.month {
                    content.body = "\(timeMonth)-\(timeDay)\(NSLocalizedString("is", comment: ""))\(title)\(year)\(NSLocalizedString("Anniversary", comment: ""))"
                }
            } else {
                content.body = "\(time)\(NSLocalizedString("is", comment: ""))\(title)\(NSLocalizedString("Birthday", comment: ""))"
            }
            content.sound = UNNotificationSound.default
            if gift == "true" {
                content.subtitle = NSLocalizedString("Remember to prepare a gift.", comment: "")
            }else {
                content.subtitle = NSLocalizedString("Happy to have a good day", comment: "")
            }
            var components = DateComponents()
            switch remindType {
            case NSLocalizedString("One day", comment: "") :
                var interval = dateTime.timeIntervalSince1970
                interval -= 86400
                dateTime = Date(timeIntervalSince1970: interval)
                components = Calendar.current.dateComponents([.month, .day],   from: dateTime)
                break
            case NSLocalizedString("One week", comment: ""):
                var interval = dateTime.timeIntervalSince1970
                interval -= 86400 * 7
                dateTime = Date(timeIntervalSince1970: interval)
                components = Calendar.current.dateComponents([.month, .day],   from: dateTime)
                break
            case NSLocalizedString("One month", comment: ""):
                var interval = dateTime.timeIntervalSince1970
                interval -= 86400 * 30
                dateTime = Date(timeIntervalSince1970: interval)
                components = Calendar.current.dateComponents([.month, .day],   from: dateTime)
                break
            default:
                break
            }
            components.hour = 8
            components.minute = 0
            let calanderTrigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
            let req  = UNNotificationRequest(identifier: title, content: content, trigger: calanderTrigger)
            UNUserNotificationCenter.current().add(req) { (error) in
                if let error = error {
                    print("error:\(error)")
                } else {
                    print("add done")
                }
            }
        }
    }
}
