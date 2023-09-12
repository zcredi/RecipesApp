import UIKit

extension UIView {
    convenience init(withBackgroundColor backgroundColor: UIColor, cornerRadius: CGFloat) {
        self.init()
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.layer.cornerCurve = .continuous
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
