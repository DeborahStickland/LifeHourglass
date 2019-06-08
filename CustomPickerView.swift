import UIKit
typealias didSelectAction = (_ didSelectRow: String, _ row: Int)->Void
class CustomPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    private var dataList: [String]!
    private var pickerTextField: UITextField!
    private var selectedHandler: (didSelectAction)?
    init(data: [String],textField: UITextField, selectedHandler: @escaping didSelectAction) {
        super.init(frame: CGRect.zero)
        self.dataList = data
        self.pickerTextField = textField
        self.delegate = self
        self.dataSource = self
        self.showsSelectionIndicator = true
        self.backgroundColor = UIColor.white
        textField.inputView = self
        self.selectedHandler = selectedHandler
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataList.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataList[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedHandler!(dataList[row], row)
    }
}
