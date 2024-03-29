import UIKit
class DetailViewController: UIViewController {
    var content: ContentMo!
    private lazy var contentLabel : UILabel = {
        let label = UILabel()
        label.font = font
        label.textAlignment = .left
        label.textColor = kGrayColor
        label.numberOfLines = 0
        return label
    }()
    let font = UIFont.systemFont(ofSize: 16)
    @IBOutlet weak var scrollView: UIScrollView!
    @IBAction func edit(_ sender: UIBarButtonItem) {
        let postNav = storyboard?.instantiateViewController(withIdentifier: "postViewC")
        navigationController?.present(postNav!, animated: true, completion: nil)
        kDefaults.set(content.contentLabel, forKey: "content")
        kDefaults.set(content.timestamp, forKey: "timestamp")
        kDefaults.set(true, forKey: "isCompile")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        notification()
    }
    func notification()  {
        let notifiMycationName = NSNotification.Name(rawValue: "contentAlter")
        NotificationCenter.default.addObserver(self, selector: #selector(updateChange(notif:)), name: notifiMycationName, object: nil)
    }
    @objc func updateChange(notif: Notification) {
        guard let string : String = notif.object as? String else { return }
        let contentRect = contentHeight(string: string)
        contentLabel.frame = CGRect(x: 20, y: 20, width: kScreenW - 40, height: contentRect.size.height)
        contentLabel.text = string
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
extension DetailViewController {
    func setupUI() {
        let contentRect = contentHeight(string: content.contentLabel!)
        contentLabel.frame = CGRect(x: 20, y: 20, width: kScreenW-40, height: contentRect.size.height)
        contentLabel.text = content.contentLabel
        scrollView.addSubview(contentLabel)
        scrollView.alwaysBounceVertical = true;
    }
    func contentHeight(string: String) -> CGRect {
        let size = CGSize(width: kScreenW - 40, height: 999999999)
        let attributes = [NSAttributedString.Key.font:font]
        let contentRect: CGRect = string.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        scrollView.contentSize = CGSize(width: contentRect.size.width, height: contentRect.size.height+40)
        return contentRect
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
}
