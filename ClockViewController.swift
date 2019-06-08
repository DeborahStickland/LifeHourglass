import UIKit
class ClockViewController: UIViewController {
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var lapView: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    private let counter = LifeSpanCounter()
    private var waveView: WaveAnimationView!
    private lazy var setupWaveView: (()->Void)? = {
        self.waveView = self.setupWaveAnimationView(front: UIColor.white.withAlphaComponent(0.5), back: UIColor.white.withAlphaComponent(0.5), frame: CGRect(x: 0, y: 0, width: self.lapView.bounds.size.width, height: self.lapView.bounds.size.height), mask: UIImage(named: "heart"))
        let layer = self.setupGradientLayer(colors: [UIColor(hexcode: "#88d3ce", alpha: 1).cgColor, UIColor(hexcode: "#6e45e2", alpha: 1).cgColor], frame: self.view.frame)
        self.view.layer.insertSublayer(layer, at: 0)
        self.lapView.addSubview(self.waveView)
        self.waveView.startAnimation()
        return nil
    }()
    deinit {
        waveView.stopAnimation()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.DiaryActionngLefttime("DiaryAction")
        self.settingActionwerDVLefttime("Setting")
        self.setupClockViewcYOLefttime("lifeTime")
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupWaveView?()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true;
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
            self.counter.timeUpdater(update: { (data) in
                self.yearLabel.text = String(data["limitYear"] as! Int)
                self.monthLabel.text = String(data["limitMonth"] as! Int)
                self.dayLabel.text = String(data["limitDay"] as! Int)
                self.hourLabel.text = String(data["limitHour"] as! Int)
                self.minuteLabel.text = String(data["limitMinute"] as! Int)
                self.secondLabel.text = String(data["limitSecond"] as! Int)
                self.waveView.setProgress(Float(data["totalDays"] as! Int)/Float(data["allDays"] as! Int))
                self.progressLabel.text = "\(Int(self.waveView.progress*100))%"
            })
        }
    }
    private func setupClockView() {
    }
    @IBAction func settingAction(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let settingView: SettingViewController = storyBoard.instantiateViewController(withIdentifier: "setting") as! SettingViewController
        settingView.modalPresentationStyle = .overFullScreen
        settingView.modalTransitionStyle = .crossDissolve
        self.present(settingView, animated: true, completion: nil)
    }
    @IBAction func DiaryAction(_ sender: Any) {
    }
}
