import UIKit
class FirstVC: CustomIntroViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
class SecondVC: CustomIntroViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
class ThirdVC: CustomIntroViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
let dataSouce = UserInfoDataSouce.shared
class FourthVC: CustomIntroViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func male(_ sender: UIButton) {
        dataSouce.setMale(sex: .male)
    }
    @IBAction func female(_ sender: UIButton) {
        dataSouce.setMale(sex: .female)
    }
}
class FifthVC: CustomIntroViewController, UITextFieldDelegate {
    @IBOutlet weak var inputBirthday: UITextField!
    private var picker = CustomDatePicker()
    private var date: Date!
    override func viewDidLoad() {
        super.viewDidLoad()
        inputBirthday.delegate = self
        inputBirthday.inputView = picker
        picker.addTarget(self, action: #selector(self.inputValues), for: .valueChanged)
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard let date = date else {
            let alert = UIAlertController(title: NSLocalizedString("It has not been entered.", comment: ""), message: NSLocalizedString("Please enter your age.", comment: ""), preferredStyle: UIAlertController.Style.alert)
            let okayButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(okayButton)
            present(alert, animated: true, completion: nil)
            return false
        }
        dataSouce.setBirthday(date: date)
        return true
    }
    @objc func inputValues() {
        picker.dateFormat { (string) in
            self.inputBirthday.text = string
            self.date = self.picker.date
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if inputBirthday.isFirstResponder {
            inputBirthday.resignFirstResponder()
        }
    }
}
class SixthVC: CustomIntroViewController, UITextFieldDelegate {
    @IBOutlet weak var inputAge: UITextField!
    private var pickerView: CustomPickerView!
    private var age: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView = CustomPickerView(data: makeDataList(), textField: inputAge, selectedHandler: { (string, int) in
            self.age = int
            self.inputAge.text = string
        })
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard let age = age else {
            let alert = UIAlertController(title: NSLocalizedString("It has not been entered.", comment: ""), message: NSLocalizedString("Please enter your age.", comment: ""), preferredStyle: UIAlertController.Style.alert)
            let okayButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            alert.addAction(okayButton)
            present(alert, animated: true, completion: nil)
            return false
        }
        dataSouce.setAge(age: age)
        return true
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if inputAge.isFirstResponder {
            inputAge.resignFirstResponder()
        }
    }
    private func makeDataList() -> [String]{
        var list = [Int]()
        for i in 0..<106 {
            list.append(i)
        }
        return list.map { String($0) }
    }
}
class SeventhVC: CustomIntroViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.animator.presentFinishHandler = {
            sleep(3)
            self.performSegue(withIdentifier: "toFinish", sender: nil)
        }
    }
}
class EighthVC: CustomIntroViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func finishDiagnosis(_ sender: UIButton) {
        dataSouce.saveUserInfo {
            UserDefaults.standard.set(true, forKey: "diagnosis_finished")
        }
    }
}
