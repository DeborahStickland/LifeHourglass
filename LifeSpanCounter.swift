import Foundation
class LifeSpanCounter {
    private var calendar: Calendar!
    private var userInfo: UserInfo!
    private var limitDate: Date!
    private var daysToDead: Calendar!
    private var totalDays: Calendar!
    init() {
        userInfo = UserInfoDataSouce.shared.getUserInfo()
        calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "Asia/Tokyo")!
        calendar.locale = Locale(identifier: "ja")
        setLimitDate()
    }
    func setLimitDate() {
        let age = userInfo.age
        let birthday = userInfo.birthday
        let sex = userInfo.sex
        let deadDate = setDeadDate(userSex: sex, userAge: age)
        let limitCalendar = Calendar.current
        var limitCompornets = limitCalendar
            .dateComponents([.year, .month, .day,
                             .hour, .minute, .second,
                             .nanosecond],
                            from: birthday)
        limitCompornets.year = limitCompornets.year! + deadDate
        limitDate = limitCalendar.date(from: limitCompornets)
    }
    func timeUpdater(update: ([String:Any])->Void) {
        let nowDate = Date()
        let calendar = Calendar.current
        let dayComponents = calendar.dateComponents([.year, .month, .day],from: nowDate,to: limitDate!)
        let totalDaysComponents = calendar.dateComponents([.day],from: nowDate,to: limitDate!)
        let allDaysComponents = calendar.dateComponents([.day],from: userInfo.birthday,to: limitDate!)
        let hour = calendar.component(.hour, from: nowDate)
        let minute = calendar.component(.minute, from: nowDate)
        let second = calendar.component(.second, from: nowDate)
        let limitHour = 24 - hour
        let limitMinute = 60 - minute
        let limitSecond = 60 - second
        let percentage = Float(totalDaysComponents.day!)/Float(allDaysComponents.day!)
        let newValues:[String:Any] = [
            "limitYear":dayComponents.year!,
            "limitMonth":dayComponents.month!,
            "limitDay":dayComponents.day!,
            "totalDays":totalDaysComponents.day!,
            "allDays":allDaysComponents.day!,
            "limitHour":limitHour,
            "limitMinute":limitMinute,
            "limitSecond":limitSecond
        ]
        update(newValues)
    }
    private func setDeadDate(userSex: Bool, userAge: Int) -> Int {
        var date: Int!
        if userSex {
            switch userAge {
            case 1...21:
                date = 81
            case 0, 22...48:
                date = 82
            case 49...58:
                date = 83
            case 59...64:
                date = 84
            case 65...69:
                date = 85
            case 70...72:
                date = 86
            case 73...75:
                date = 87
            case 76...78:
                date = 88
            case 79...81:
                date = 89
            case 82,83:
                date = 90
            case 84,85:
                date = 91
            case 86,87:
                date = 92
            case 88:
                date = 93
            case 89,90:
                date = 94
            case 91:
                date = 95
            case 92,93:
                date = 96
            case 94:
                date = 97
            case 95,96:
                date = 98
            case 97:
                date = 99
            case 98:
                date = 100
            case 99:
                date = 101
            case 100:
                date = 102
            case 101:
                date = 103
            case 102,103:
                date = 104
            case 104:
                date = 105
            case 105:
                date = 106
            default:
                break
            }
        } else {
            switch userAge {
            case 0...8:
                date = 87
            case 9...53:
                date = 88
            case 54...65:
                date = 89
            case 66...73:
                date = 90
            case 74...78:
                date = 91
            case 79...82:
                date = 92
            case 83...85:
                date = 93
            case 86,87:
                date = 94
            case 88,89:
                date = 95
            case 90,91:
                date = 96
            case 92,93:
                date = 97
            case 94:
                date = 98
            case 95,96:
                date = 99
            case 97:
                date = 100
            case 98:
                date = 101
            case 99,100:
                date = 102
            case 101:
                date = 103
            case 102:
                date = 104
            case 103:
                date = 105
            case 104:
                date = 106
            case 105:
                date = 107
            default:
                break
            }
        }
        return date
    }
}
