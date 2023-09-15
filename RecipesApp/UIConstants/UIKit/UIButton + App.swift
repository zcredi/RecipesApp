import UIKit

extension UIButton {
    convenience init(name: String?, backgroundColor: UIColor?, font: UIFont?, titleColor: UIColor?){
        self.init()
        self.setTitle(name, for: .normal)
        self.backgroundColor = backgroundColor
        self.titleLabel?.font = font
        self.setTitleColor(titleColor, for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

