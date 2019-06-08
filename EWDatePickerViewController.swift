import UIKit
class EWDatePickerViewController: UIViewController {
    var backDate: ((Date) -> Void)?
    private var currentDateCom: DateComponents = Calendar.current.dateComponents([.year, .month, .day],   from: Date())    
    var containV:UIView = {
        let view = UIView(frame: CGRect(x: 0, y: ScreenInfo.Height-240, width: ScreenInfo.Width, height: 240))
        view.backgroundColor = UIColor.white
        return view
    }()
    var backgroundView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        return view
    }()
    var picker: UIPickerView!
    var lunar :UILabel!
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        drawMyView()
    }
    private func drawMyView(){
        view.backgroundColor = .clear
        self.view.insertSubview(self.backgroundView, at: 0)
        self.modalPresentationStyle = .custom
        let cancel = UIButton(frame: CGRect(x: 0, y: 0, width: 70, height: 30))
        let sure = UIButton(frame: CGRect(x: ScreenInfo.Width - 70, y: 0, width: 70, height: 30))
        lunar = UILabel(frame: CGRect(x: (ScreenInfo.Width-180)/2, y: 0, width: 180, height: 30))
        cancel.setTitle(NSLocalizedString("Cancel", comment: ""), for: .normal)
        sure.setTitle(NSLocalizedString("confirm", comment: ""), for: .normal)
        cancel.setTitleColor(UIColor.colorWithRGBA(r: 65, g: 105, b: 225, a: 1), for: .normal)
        sure.setTitleColor(UIColor.colorWithRGBA(r: 65, g: 105, b: 225, a: 1), for: .normal)
        cancel.addTarget(self, action: #selector(self.onClickCancel), for: .touchUpInside)
        sure.addTarget(self, action: #selector(self.onClickSure), for: .touchUpInside)
        picker = UIPickerView(frame: CGRect(x: 0, y: 24, width: ScreenInfo.Width, height: 216))
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = UIColor.clear
        picker.clipsToBounds = true
        self.containV.addSubview(cancel)
        self.containV.addSubview(sure)
        self.containV.addSubview(picker)
        self.containV.addSubview(lunar)
        self.view.addSubview(self.containV)
        self.transitioningDelegate = self as UIViewControllerTransitioningDelegate
    }
    @objc func onClickCancel() {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func onClickSure() {
        let dateString = String(format: "%02ld-%02ld-%02ld", self.picker.selectedRow(inComponent: 0) + (self.currentDateCom.year!)-49, self.picker.selectedRow(inComponent: 1) + 1, self.picker.selectedRow(inComponent: 2) + 1)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        if self.backDate != nil{
            self.backDate!(dateFormatter.date(from: dateString) ?? Date())
        }
        self.dismiss(animated: true, completion: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
extension EWDatePickerViewController:UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 50
        }else if component == 1 {
            let selectYear = self.picker.selectedRow(inComponent: 0) - 49 + currentDateCom.year!
            if(selectYear != currentDateCom.year! )
            {
                return 12;
            }else{
                return currentDateCom.month!
            }
        }else {
            let selectMouth = self.picker.selectedRow(inComponent: 1) + 1
            let selectYear = self.picker.selectedRow(inComponent: 0) - 49 + currentDateCom.year!
            if(selectMouth == currentDateCom.month! && selectYear == currentDateCom.year ){
                return currentDateCom.day!
            }else{
            let year: Int = pickerView.selectedRow(inComponent: 0) + currentDateCom.year!
            let month: Int = pickerView.selectedRow(inComponent: 1) + 1
            let days: Int = howManyDays(inThisYear: year, withMonth: month)
            return days
            }
        }
    }
    private func howManyDays(inThisYear year: Int, withMonth month: Int) -> Int {
        if (month == 1) || (month == 3) || (month == 5) || (month == 7) || (month == 8) || (month == 10) || (month == 12) {
            return 31
        }
        if (month == 4) || (month == 6) || (month == 9) || (month == 11) {
            return 30
        }
        if (year % 4 == 1) || (year % 4 == 2) || (year % 4 == 3) {
            return 28
        }
        if year % 400 == 0 {
            return 29
        }
        if year % 100 == 0 {
            return 28
        }
        return 29
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return ScreenInfo.Width / 3
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return "\((currentDateCom.year!) + row - 49)\(NSLocalizedString("year", comment: ""))"
        }else if component == 1 {
            return "\(row + 1)\(NSLocalizedString("month", comment: ""))"
        }else {
            return "\(row + 1)\(NSLocalizedString("day", comment: ""))"
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 1 {
            pickerView.reloadComponent(2)
        }
        if component == 0 {
            pickerView.reloadComponent(1)
            pickerView.reloadComponent(2)
        }
        let lunar = dateTools.solarToLunar(year: self.picker.selectedRow(inComponent: 0) + (self.currentDateCom.year!)-49, month: self.picker.selectedRow(inComponent: 1) + 1, day: self.picker.selectedRow(inComponent: 2) + 1)
        print(self.picker.selectedRow(inComponent: 0) - 49 + currentDateCom.year!)
    }
}
extension EWDatePickerViewController:UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animated = EWDatePickerPresentAnimated(type: .present)
        return animated
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animated = EWDatePickerPresentAnimated(type: .dismiss)
        return animated
    }
}
