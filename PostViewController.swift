import UIKit
import CoreData
class PostViewController: UIViewController {
    var content: ContentMo!
    @IBAction func save(_ sender: UIBarButtonItem) {
        if textView.text.isEmpty {
            dismiss(animated: true, completion: nil)
            return
        }
        if kDefaults.bool(forKey: "isCompile") {
            guard let inquire = inquire else {return}
            reviseContent(timeStamp: Int64(inquire))
            kDefaults.set(false, forKey: "isCompile")
            return
        }
        content = ContentMo(context: kContext)
        let dictionary = Date.getTimes()
        content.contentLabel = textView.text
        content.timeLabel = dictionary["time"] as? String
        content.dayLabel = dictionary["day"] as? String
        content.yearAndMonthLabel = dictionary["yearAndMonth"] as? String
        content.timestamp = dictionary["timestamp"] as! Int64
        content.dayOfWeek = dictionary["dayOfWeek"] as! Int16
        kAppDelegate.saveContext()
        dismiss(animated: true, completion: nil)
    }
    let notifiMycationName = NSNotification.Name(rawValue: "contentAlter")
    func tempbuttonAction() {
        NotificationCenter.default.post(name: notifiMycationName, object: textView.text)
    }
    func reviseContent(timeStamp: Int64) {
        let dictionary = Date.getTimes()
        let request: NSFetchRequest<ContentMo> = ContentMo.fetchRequest()
        let pre = NSPredicate.init(format: "timestamp = %d", timeStamp)
        request.predicate = pre
        do {
            let result = try kAppDelegate.persistentContainer.viewContext.fetch(request)
            for content in result {
                content.contentLabel = textView.text
                content.timeLabel = dictionary["time"] as? String
                content.dayLabel = dictionary["day"] as? String
                content.yearAndMonthLabel = dictionary["yearAndMonth"] as? String
                content.timestamp = dictionary["timestamp"] as! Int64
                content.dayOfWeek = dictionary["dayOfWeek"] as! Int16
                kAppDelegate.saveContext()
                tempbuttonAction()
                dismiss(animated: true, completion: nil)
            }
        } catch  {
            print(error)
        }
    }
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        kDefaults.set(false, forKey: "isCompile")
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var textView: UITextView!
    var inquire : Int? 
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.textColor = kGrayColor
        textView.becomeFirstResponder()
        self.needCompileFuhrZLefttime("liftTime")
        self.reviseContentSSKYtLefttime("ssj", timeStamp: 16)
    }
    func needCompile() {
        textView.text = kDefaults.string(forKey: "content")
        inquire = kDefaults.integer(forKey: "timestamp")
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        textView.resignFirstResponder()
    }
    override func viewWillAppear(_ animated: Bool) {
        if kDefaults.bool(forKey: "isCompile") {
            needCompile()
        }
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isTranslucent = false;
        self.navigationController?.navigationBar.barTintColor = UIColor(hexcode: "#6e45e2", alpha: 1)
        self.navigationController?.navigationBar.shadowImage = UIImage();
        let layer = self.setupGradientLayer(colors: [UIColor(hexcode: "#88d3ce", alpha: 1).cgColor, UIColor(hexcode: "#6e45e2", alpha: 1).cgColor], frame: self.view.frame)
        self.view.layer.insertSublayer(layer, at: 0)
        self.navigationItem.title = "Add Diary";
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}
