import UIKit

extension UITextField {
    convenience init(placeholder: String, delegate: UITextFieldDelegate) {
        self.init()
        self.placeholder = placeholder
        self.borderStyle = .roundedRect
        self.delegate = delegate
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
