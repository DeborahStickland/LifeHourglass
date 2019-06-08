import UIKit
extension UIViewController {
    public func setupGradientLayer(colors:[CGColor], frame: CGRect) -> CAGradientLayer {
        let layer = CAGradientLayer()
        layer.frame = frame
        layer.colors = colors
        layer.startPoint = CGPoint(x: 0, y: 1)
        layer.endPoint = CGPoint(x: 1, y: 0)
        return layer
    }
    public func setupWaveAnimationView(front: UIColor, back: UIColor, frame: CGRect, mask: UIImage?) -> WaveAnimationView {
        let waveView = WaveAnimationView(frame: frame, frontColor: front, backColor: back)
        waveView.maskImage = mask
        waveView.layer.shadowColor = UIColor.white.cgColor
        waveView.layer.shadowRadius = 20
        waveView.layer.shadowOpacity = 1
        return waveView
    }
    public func shareLifeSpanWithImage(progress: Int) {
        let url = URL(string: "https://apple.co/2HCuWCa")
        let sharedText = "\(NSLocalizedString("Your remaining life is", comment: ""))「\(progress)%」\(NSLocalizedString("is", comment: ""))。|  \(NSLocalizedString("Heart-shaped life countdown", comment: ""))「Limit」- \(url!)"
        let sharedImage = self.getScreenShot()
        let items:[Any] = [sharedText, sharedImage]
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
    }
    public func shareLimit() {
        let url = URL(string: "https://apple.co/2HCuWCa")
        let sharedText = "\(NSLocalizedString("Heart-shaped life countdown", comment: ""))「Limit」\(NSLocalizedString("Share", comment: ""))！-\(url!)"
        let items:[Any] = [sharedText]
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
    }
    public func openAppStore() {
        let limitUrl = "https://itunes.apple.com/jp/app/limit/id1441079872?mt=8"
        guard let url = URL(string: limitUrl) else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    private func getScreenShot() -> UIImage {
        let captureSize = self.view.bounds.size
        UIGraphicsBeginImageContextWithOptions(captureSize, false, 0.0)
        let context:CGContext = UIGraphicsGetCurrentContext()!
        self.view.layer.render(in: context)
        let captureImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return captureImage
    }
}
