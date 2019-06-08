import UIKit
protocol addOneNoteProtocol:NSObjectProtocol {
    func callBack(newData:NSMutableDictionary,editType:String)
    func dismisVC()
}
class AddPageViewController: UIViewController {
    weak var  delegate : addOneNoteProtocol?;
    var data : NSMutableDictionary = NSMutableDictionary()
    let remindTypeStr = [NSLocalizedString("One day", comment: ""),NSLocalizedString("One week", comment: ""),NSLocalizedString("One month", comment: "")]
    let dayTypeStr = [NSLocalizedString("Birthday", comment: ""),NSLocalizedString("Anniversary", comment: "")]
    var myView :AddNoteView?;
    var editType :String = NSLocalizedString("add", comment: "")
    override func viewDidLoad() {
        super.viewDidLoad()
        myView = AddNoteView(frame: self.view.frame);
        if let myView = self.myView{
            self.view.addSubview(myView);
            self.view.backgroundColor = UIColor.white;
            self.navigationItem.title = "";
            myView.submit.addTarget(self, action: #selector(submitData(_:)), for: .touchUpInside)
            myView.title.delegate = self
            myView.timeText.delegate = self
        }
        self.backToRootVCEArbLefttime("backInfo")
        if (data.count>0) {
            edit(data);
            editType = NSLocalizedString("edit", comment: "")
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        myView?.title.endEditing(true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.colorWithRGBA(r: 65, g: 105, b: 225, a: 1)]
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default);
        self.navigationController?.navigationBar.shadowImage = UIImage();
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "buttonBack"), style: .plain, target: self, action: #selector(backToRootVC))
    }
    @objc func backToRootVC()  {
        delegate?.dismisVC()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true) 
    }
}
extension AddPageViewController{
    @objc func onClickSelectButton( _ sender: UITapGestureRecognizer){
        let dataPicker = EWDatePickerViewController()
        self.definesPresentationContext = true
        dataPicker.backDate = { [weak self] date in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd"
            let dateString: String = dateFormatter.string(from: date)
            self?.myView?.timeText.text = dateString
        }
        dataPicker.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        dataPicker.picker.reloadAllComponents()
        self.present(dataPicker, animated: true) {
            dataPicker.picker.selectRow(49, inComponent: 0, animated: false)
            dataPicker.picker.reloadComponent(1);
            dataPicker.picker.selectRow((dateTools.currentDateCom.month!) - 1, inComponent: 1, animated:   false)
            dataPicker.picker.reloadComponent(2);
            dataPicker.picker.selectRow((dateTools.currentDateCom.day!) - 1, inComponent: 2, animated: false)
        }
    }
    func showDatePicker() {
        let dataPicker = EWDatePickerViewController()
        self.definesPresentationContext = true
        dataPicker.backDate = { [weak self] date in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd"
            let dateString: String = dateFormatter.string(from: date)
            self?.myView?.timeText.text = dateString
        }
        dataPicker.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        dataPicker.picker.reloadAllComponents()
        self.present(dataPicker, animated: true) {
            dataPicker.picker.selectRow(49, inComponent: 0, animated: false)
            dataPicker.picker.reloadComponent(1);
            dataPicker.picker.selectRow((dateTools.currentDateCom.month!) - 1, inComponent: 1, animated:   false)
            dataPicker.picker.reloadComponent(2);
            dataPicker.picker.selectRow((dateTools.currentDateCom.day!) - 1, inComponent: 2, animated: false)
        }
    }
    @objc func submitData(_ sender:UIButton){
       if let title = myView?.title.text,let time = myView?.timeText.text{
        if(title.isEmpty){
            myView?.title.shake(direction: .horizontal, times: 3, interval: 0.1, delta: 5, completion: {
                print("The title can not be blank")
            })
            return
        }
        if(time.isEmpty){
            myView?.timeText.shake(direction: .horizontal, times: 3, interval: 0.1, delta: 5, completion: {
                print("Date cannot be empty")
            })
            return
        }
        }
        let dict =  makeDict();
        delegate?.callBack(newData: dict ,editType: editType);
        self.navigationController?.popViewController(animated: true);
    }
    func makeDict() -> NSMutableDictionary{
        let dict = NSMutableDictionary()
        print(dict)
        dict["title"] = myView?.title.text ?? "nil";
        dict["time"] = myView?.timeText.text ?? "nil";
        if(myView?.gift.isOn ?? false)
        {
            dict["isNeedGift"] = "true";
        }else{
            dict["isNeedGift"] = "false";
        }
        if(myView?.remind.isOn ?? false)
        {
            dict["isRemind"] = "true";
        }else{
            dict["isRemind"] = "false";
        }
        dict["remindType"] = remindTypeStr[myView?.remindType.selectedSegmentIndex ?? 0];
        dict["dayType"] = dayTypeStr[myView?.dayType.selectedSegmentIndex ?? 0];
        return dict
    }
    func edit(_ myData:NSMutableDictionary)  {
        if let time = myData["time"] as! String? ,let title = myData["title"] as! String? {
            myView?.timeText.text = time
            myView?.title.text = title
        }
        if let inRemind = myData["isRemind"] as! String? {
            if(inRemind == "true") {
                myView?.remind.isOn = true
                myView?.remindType.isHidden = false
                myView?.littleLable.isHidden = false
            } else {
                myView?.remind.isOn = false
                myView?.remindType.isHidden = true
                myView?.littleLable.isHidden = true
            }
        }
        if  let isNeedGift = myData.value(forKey: "isNeedGift") as! String? {
            if(isNeedGift  == "true") {
                myView?.gift.isOn = true
            } else {
                myView?.gift.isOn = false
            }
        }
        if let remindType = myData["remindType"] as! String? {
            if( remindType == NSLocalizedString("One day", comment: "")) {
                myView?.remindType.selectedSegmentIndex = 0
            }else if (remindType == NSLocalizedString("One week", comment: "")) {
                myView?.remindType.selectedSegmentIndex = 1
            }else {
                myView?.remindType.selectedSegmentIndex = 2
            }
        }
        if let dayType = myData["dayType"] as! String? {
            if( dayType == NSLocalizedString("Birthday", comment: "")) {
                myView?.dayType.selectedSegmentIndex = 0
            }else {
                myView?.dayType.selectedSegmentIndex = 1
            }
        }
        if let str = myData["remindType"] {
            myView?.littleLable.text = "\(NSLocalizedString("Reminder in advance", comment: "")):\(str)"
        }
    }
}
extension AddPageViewController :UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if(textField == myView?.title) {
            return true
        } else {
             myView?.title.endEditing(true)
            showDatePicker()
            return false
        }
    }
}
