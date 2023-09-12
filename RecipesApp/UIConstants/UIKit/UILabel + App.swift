import UIKit

extension UILabel {
    
    convenience init(text: String = "", font: UIFont?, textColor: UIColor, textAligment: NSTextAlignment? = .center, numberOfLines: Int) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
        self.adjustsFontSizeToFitWidth = true
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
