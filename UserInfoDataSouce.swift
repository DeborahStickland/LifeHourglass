import Foundation
class UserInfoDataSouce {
    static let shared = UserInfoDataSouce()
    private var sexInput: Bool?
    private var ageInput: Int?
    private var dateInput: Date?
    func setMale(sex: SexParams) {
        sexInput = sex.key
    }
    func setBirthday(date: Date) {
        dateInput = date
    }
    func setAge(age: Int) {
        ageInput = age
    }
    func getUserInfo() -> UserInfo? {
        guard let data = UserDefaults.standard.data(forKey: "UserInfo"),
            let userInfo = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UserInfo else {
                return nil
        }
        return userInfo
    }
    func saveUserInfo(completion:()->Void) {
        let data = UserInfo(sex: sexInput!, age: ageInput!, birthday: dateInput!)
        if #available(iOS 11.0, *) {
            let archiveData = try! NSKeyedArchiver.archivedData(withRootObject: data, requiringSecureCoding: false)
            UserDefaults.standard.set(archiveData, forKey: "UserInfo")
            UserDefaults.standard.synchronize()
            completion()
        } else {
        }
    }
    func resetUserInfo() {
        if UserDefaults.standard.data(forKey: "UserInfo") == nil,
            UserDefaults.standard.bool(forKey: "diagnosis_finished") == false {
            return
        }
        UserDefaults.standard.removeObject(forKey: "UserInfo")
        UserDefaults.standard.set(false, forKey: "diagnosis_finished")
    }
}
