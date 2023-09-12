import UIKit

class CreateRecipeTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .neutral0
        layer.cornerRadius = 10
        textColor = .neutral100
        font = .poppinsRegular14()
        layer.borderWidth = 1
        layer.borderColor = UIColor.primary50.cgColor
        borderStyle = .none
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        leftViewMode = .always
        clearButtonMode = .never
        returnKeyType = .done
    }
}

//MARK: - UITextFieldDelegate

extension CreateRecipeTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
