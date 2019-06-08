import UIKit
class MomentCell: UITableViewCell {
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var yearAndMonth: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    var content : ContentMo? {
        didSet {
            guard let content = content else { return }
            let contentStr : String = content.contentLabel!
            let whitespacen = CharacterSet.whitespacesAndNewlines
            let mayShowContent = contentStr.trimmingCharacters(in: whitespacen)
            contentLabel.text = mayShowContent
            timeLabel.text = content.timeLabel
            dayLabel.text = content.dayLabel
            yearAndMonth.text = content.yearAndMonthLabel
        }
    }
}
