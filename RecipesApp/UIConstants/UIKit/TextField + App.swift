import UIKit

extension UITextField {
    convenience init(placeholder: String, font: UIFont ) {
        self.init()
        self.placeholder = placeholder
        self.borderStyle = .roundedRect
        self.font = font
    }
}
