import Foundation
class UserInfo:NSObject, NSCoding {
    var sex: Bool
    var age: Int
    var birthday: Date
    init(sex: Bool, age: Int, birthday: Date) {
        self.sex = sex
        self.age = age
        self.birthday = birthday
    }
    required init?(coder aDecoder: NSCoder) {
        sex = aDecoder.decodeBool(forKey: "UserSex")
        age = aDecoder.decodeInteger(forKey: "UserAge")
        birthday = aDecoder.decodeObject(forKey: "Birthday") as! Date
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(sex, forKey: "UserSex")
        aCoder.encode(age, forKey: "UserAge")
        aCoder.encode(birthday, forKey: "Birthday")
    }
}
enum SexParams {
    case male
    case female
    var key: Bool {
        switch self {
        case .male:
            return true
        case .female:
            return false
        }
    }
}
