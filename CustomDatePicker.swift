import UIKit
class CustomDatePicker: UIDatePicker {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.maximumDate = NSDate() as Date
        self.datePickerMode = UIDatePicker.Mode.date
        self.locale = NSLocale(localeIdentifier: "en_US") as Locale
        self.backgroundColor = UIColor.white
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func dateFormat(completion: @escaping (String)->Void) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US") as Locale
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.dateFormat = "yyyy-M-d"
        completion(dateFormatter.string(from: self.date))
    }
}
