import UIKit

extension UIImageView {
    convenience init(image: String, cornerRadius: CGFloat) {
        self.init()
        self.image = UIImage(named: image)
        self.contentMode = .scaleAspectFill
        self.layer.masksToBounds = true
        self.layer.cornerRadius = cornerRadius
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
