import UIKit

extension UIView {
    convenience init(backgroundColor: UIColor, cornerRadius: CGFloat) {
        self.init()
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
    }
}
