import UIKit
import CoreData
class ListTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    private var headPortrait : UIImageView!
    private var letfBtnView: UIView!
    private var contents : [ContentMo] = []
    private var content : ContentMo!
    private var fc : NSFetchedResultsController<ContentMo>!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.notificationCenterMWpsLefttime("mtapp")
        self.photoSelectedeyExLefttime("uptoapp")
        self.touchInfobXGPLefttime("leftTime")
        self.navigationController?.isNavigationBarHidden = false
        setupUI()
        fetchAllData()
        notificationCenter()
        if !(kDefaults.bool(forKey: "ifFirst")) {
            nllcontent()
        }
        DataExtensions.fetcAllData()
        showInfo()
    }
    private func notificationCenter() {
        let notifiMycationName = NSNotification.Name(rawValue: "saveInfo")
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateChange),
                                               name: notifiMycationName,
                                               object: nil)
    }
    @objc func updateChange() {
        showInfo()
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    private func touchInfo() {
        headPortrait.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(backVC))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        headPortrait.addGestureRecognizer(tap)
    }
    @objc func photoSelected() {
    }
    private func showInfo() {
    }
    private func nllcontent2(i: Int) {
        content = ContentMo(context: kContext)
        content.contentLabel = "😂😂😂😂😂"
        content.dayLabel = "\(22 + i)"
        content.yearAndMonthLabel = "2017/6"
        content.timeLabel = "22:22 "
        content.timestamp = 7 + Int64(i)
        content.dayOfWeek = Int16(i)
        kAppDelegate.saveContext()
    }
    private func nllcontent() {
        content = ContentMo(context: kContext)
        content.contentLabel = """
        Welcome to the diary🤤
        The diary will show you 7 days of the week in different colors.
        Give you a different feeling every day
        If you insist on writing a diary every day
        After 7 days you will see the rainbow🌈!
        Go ahead and write one.🙈
        """
        content.dayLabel = "17"
        content.yearAndMonthLabel = "2017/2"
        content.timeLabel = "22:22"
        content.timestamp = 1
        content.dayOfWeek = 5
        kAppDelegate.saveContext()
        kDefaults.set(true, forKey: "ifFirst")
    }
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .automatic)
        default:
            tableView.reloadData()
        }
        if let object = controller.fetchedObjects {
            contents = object as! [ContentMo]
        }
    }
    private func fetchAllData() {
        let request : NSFetchRequest<ContentMo> = ContentMo.fetchRequest()
        let sd = NSSortDescriptor(key: "timestamp", ascending: false)
        request.sortDescriptors = [sd]
        fc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: kContext, sectionNameKeyPath: nil, cacheName: nil)
        fc.delegate = self
        do {
            try fc.performFetch()
            if let object = fc.fetchedObjects {
                contents = object
            }
        } catch {
            print(error)
        }
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            kContext.delete(self.fc.object(at: indexPath))
            kAppDelegate.saveContext()
        }
    }
    @IBAction func close(segue: UIStoryboardSegue)  {}
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetil" {
            let detail = segue.destination as! DetailViewController
            detail.content = contents[tableView.indexPathForSelectedRow!.row]
        }
    }
}
extension ListTableViewController {
    private func setupUI() {
        setupNaviBar()
        tableView.separatorColor = UIColor(white: 1, alpha: 0.66)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    private func setupNaviBar()  {
        letfBtnView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        letfBtnView.backgroundColor = UIColor.clear
        headPortrait = UIImageView(frame: CGRect(x: 0, y: (letfBtnView.frame.height - kHeadPortraitW) / 2, width: kHeadPortraitW, height: kHeadPortraitW))
        letfBtnView.addSubview(headPortrait)
        let leftBtn = UIBarButtonItem.init(customView: letfBtnView)
        navigationItem.leftBarButtonItem = leftBtn
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
extension ListTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Moment", for: indexPath) as! MomentCell
        cell.content = contents[indexPath.row]
        cell.selectedBackgroundView = UIView()
        switch contents[indexPath.row].dayOfWeek {
        case 1:
            customCell(cell: cell, labels: [cell.contentLabel, cell.dayLabel, cell.yearAndMonth, cell.timeLabel], textColor: kWhite, bgc: kCheng, selectColor: kSelectedCheng)
        case 2:
            customCell(cell: cell, labels: [cell.contentLabel, cell.dayLabel, cell.yearAndMonth, cell.timeLabel], textColor: kBlack, bgc: kHuang, selectColor: kSelectedHuang)
        case 3:
            customCell(cell: cell, labels: [cell.contentLabel, cell.dayLabel, cell.yearAndMonth, cell.timeLabel], textColor: kWhite, bgc: kLv, selectColor: kSelectedLv)
        case 4:
            customCell(cell: cell, labels: [cell.contentLabel, cell.dayLabel, cell.yearAndMonth, cell.timeLabel], textColor: kBlack, bgc: kQing, selectColor: kSelectedQing)
        case 5:
            customCell(cell: cell, labels: [cell.contentLabel, cell.dayLabel, cell.yearAndMonth, cell.timeLabel], textColor: kWhite, bgc: kLan, selectColor: kSelectedLan)
        case 6:
            customCell(cell: cell, labels: [cell.contentLabel, cell.dayLabel, cell.yearAndMonth, cell.timeLabel], textColor: kWhite, bgc: kZi, selectColor: kSelectedZi)
        default:
            customCell(cell: cell, labels: [cell.contentLabel, cell.dayLabel, cell.yearAndMonth, cell.timeLabel], textColor: kWhite, bgc: kChi, selectColor: kSelectedChi)
        }
        return cell
    }
    private func customCell(cell: UITableViewCell,labels: [UILabel], textColor: UIColor, bgc:UIColor, selectColor: UIColor)  {
        cell.backgroundColor = bgc
        cell.selectedBackgroundView?.backgroundColor = selectColor
        for label in labels {
            label.textColor = textColor
        }
    }
    override func viewDidLayoutSubviews() {
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.layoutMargins = UIEdgeInsets.zero
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isTranslucent = false;
        self.navigationController?.navigationBar.barTintColor = UIColor(hexcode: "#6e45e2", alpha: 1)
        self.navigationController?.navigationBar.shadowImage = UIImage();
        self.tableView.backgroundColor = UIColor(hexcode: "#6e45e2", alpha: 1)
        self.navigationItem.title = "Record Everyday";
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "buttonBack"), style: .plain, target: self, action: #selector(backVC))
    }
    @objc func backVC() {
        dismiss(animated: true, completion: nil)
    }
}
