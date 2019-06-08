import UIKit
class CollectionViewCell: UICollectionViewCell {
    let littleFont = UIFont.systemFont(ofSize: 12)
    var titleLabel = UILabel()
    var midLabel = UILabel()
    var timeLabel = UILabel()
    var dayIntervalLabel = UILabel()
    var giftImageView = UIImageView()
    var dayTypeImageView = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        midLabel.font = littleFont
        timeLabel.font = littleFont
        self.addSubview(titleLabel)
        self.addSubview(midLabel)
        self.addSubview(timeLabel)
        self.addSubview(giftImageView)
        self.addSubview(dayIntervalLabel)
        self.addSubview(dayTypeImageView)
        self.backgroundColor = UIColor.white
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 5
        self.layer.cornerRadius = 5
        dayIntervalLabel.textAlignment = .right;
        giftImageView.image = UIImage(named: "gift");
    }
    func initData(_ note:NSDictionary) {
        let dateFormatter = DateFormatter()
        let today = Date()
        dateFormatter.dateFormat = "yyy-MM-dd"
        if  let title = note["title"] as? String ,
            let time = note["time"] as? String ,
            let dayType = note["dayType"] as? String,
            let isNeedGift = note["isNeedGift"]as? String ,
            let dateTime = dateFormatter.date(from: time) {
            let compThatday = Calendar.current.dateComponents([.year,.month,.day], from: dateTime)
            let compToday = Calendar.current.dateComponents([.year,.month,.day], from: today)
            let yearInterval = dateTools.compare2Date(FromDate: dateTime, ToDate:today) / 365
            titleLabel.text = title
            timeLabel.text = time
            if dayType == NSLocalizedString("Birthday", comment: "") {
                dayTypeImageView.image = UIImage(named: "birthday")
                if let year = compThatday.year,let month = compThatday.month,let day = compThatday.day {
                    midLabel.text = dateTools.solarToLunar(year: year, month: month, day:day )
                }
                let days = dateTools.calcunateCuntdownDays(birthday: time)
                dayIntervalLabel.text = "\(days)\(NSLocalizedString("days later", comment: ""))"
            }else {
                dayTypeImageView.image = UIImage(named: "anniversary")
                dayIntervalLabel.text = "\(dateTools.calcunateCuntdownDays(birthday: time))\(NSLocalizedString("day", comment: ""))";
                midLabel.text = "\(yearInterval+1)\(NSLocalizedString("days from the anniversary", comment: ""))"
            }
            if(isNeedGift == "false"){
                giftImageView.isHidden = true;
            }
            if compThatday.month == compToday.month && compThatday.day == compToday.day {
                dayIntervalLabel.text = NSLocalizedString("Nowadays", comment: "")
                self.backgroundColor = UIColor.colorWithRGBA(r: 255, g: 250, b: 205, a: 1)
                if dayType == NSLocalizedString("Anniversary", comment: "") {
                    if yearInterval != 0 {
                        midLabel.text = "\(yearInterval) \(NSLocalizedString("Anniversary", comment: "") )"
                    } else {
                        midLabel.text = NSLocalizedString("New anniversary", comment: "")
                    }
                }
            }else {
                self.backgroundColor = UIColor.white 
            }
        }
    }
    override func layoutSubviews() {
        let label_X :CGFloat = 10
        let lebel_Y :CGFloat = 5
        let labelWidth :CGFloat = 200
        let lableHeight = (self.bounds.size.height - 10)/3;
        let imageSize :CGFloat = 20
        titleLabel.frame = CGRect(x: label_X, y: lebel_Y, width: labelWidth, height: lableHeight);
        midLabel.frame = CGRect(x: label_X, y: lebel_Y+lableHeight, width: labelWidth, height: lableHeight)
        timeLabel.frame = CGRect(x: label_X, y: lebel_Y+lableHeight*2, width: labelWidth, height: lableHeight)
        dayTypeImageView.frame = CGRect(x: self.bounds.size.width-30, y:lebel_Y , width: imageSize, height: imageSize)
        dayIntervalLabel.frame = CGRect(x: self.bounds.size.width-160, y: lebel_Y+40, width: 150, height: 20)
        giftImageView.frame = CGRect(x: dayTypeImageView.frame.origin.x - 30 , y:lebel_Y , width: imageSize, height: imageSize)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
