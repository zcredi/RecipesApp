import UIKit

extension UIStackView {
    convenience init(axis: NSLayoutConstraint.Axis, aligment: UIStackView.Alignment, spacing: CGFloat) {
        self.init()
        self.axis = axis
        self.alignment = aligment
        self.spacing = spacing
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
