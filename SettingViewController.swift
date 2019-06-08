import UIKit
class SettingViewController: UIViewController {
    @IBOutlet weak var settingView: UIView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var reviewButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.resetLifeSpanUOBEaLefttime("LiftSpan")
        self.resethbuZLefttime("uibutton")
        self.cancelTOfLefttime("UIbutton")
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        shareButton.layer.addSublayer(shareButton.drawSideBorder(borderWidth: 0.5, borderColor: .lightGray, UI: shareButton, side: .bottom))
        reviewButton.layer.addSublayer(reviewButton.drawSideBorder(borderWidth: 0.5, borderColor: .lightGray, UI: reviewButton, side: .bottom))
        resetButton.layer.addSublayer(resetButton.drawSideBorder(borderWidth: 0.5, borderColor: .lightGray, UI: resetButton, side: .bottom))
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let tapEvent = touches.first else { return }
        let tapLocation = tapEvent.location(in: self.view)
        if !settingView.frame.contains(tapLocation) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func reset(_ sender: UIButton) {
        resetLifeSpan()
    }
    @IBAction func share(_ sender: UIButton) {
        shareLimit()
    }
    @IBAction func review(_ sender: UIButton) {
        openAppStore()
    }
    @IBAction func cancel(_ sender: UIButton) {
         self.dismiss(animated: true, completion: nil)
    }
    private func resetLifeSpan() {
        let alert = UIAlertController(title: NSLocalizedString("Re-diagnose life span", comment: ""), message: NSLocalizedString("Reset the current life and re-diagnose. Is it OK?", comment: ""), preferredStyle: UIAlertController.Style.alert)
        let okayButton = UIAlertAction(title: "OK", style: .default) { (action) in
            UserInfoDataSouce.shared.resetUserInfo()
            sleep(1)
            let alert = UIAlertController(title: NSLocalizedString("The reset is complete.", comment: ""), message: NSLocalizedString("Exit the app and restart it.", comment: ""), preferredStyle: UIAlertController.Style.alert)
            let okayButton = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okayButton)
            self.present(alert, animated: true
                , completion: nil)
        }
        let cancelButton = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .destructive, handler: nil)
        alert.addAction(cancelButton)
        alert.addAction(okayButton)
        present(alert, animated: true, completion: nil)
    }
}
