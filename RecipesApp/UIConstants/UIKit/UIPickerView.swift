import UIKit

extension UIPickerView {

    convenience init(delegate: UIPickerViewDelegate, dataSource: UIPickerViewDataSource) {
        self.init()
        self.delegate = delegate
        self.dataSource = dataSource
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
