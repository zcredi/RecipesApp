import UIKit

protocol SwitchPopularCategoryCellDelegate: NSObject {
    func didTapButton(in cell: SwitchPopularCategoryCollectionViewCell)
}

class SwitchPopularCategoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SwitchPopularCategoryCollectionViewCell"
    weak var delegate: SwitchPopularCategoryCellDelegate?
    
    private lazy var categoryButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.poppinsRegular14()
        button.layer.cornerRadius = 10
        button.setTitleColor(.red, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(categoryButtonPressed(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @IBAction func categoryButtonPressed(_ sender: UIButton) {
        delegate?.didTapButton(in: self)
    }
    
    public func configureCell(with category: String) {
        categoryButton.setTitle(category, for: .normal)
    }
    
    public func resetButtonState(){
        categoryButton.setTitleColor(.red, for: .normal)
        categoryButton.backgroundColor = .white
    }
    
    public func toggleButtonState(){
        if categoryButton.backgroundColor == .white{
            categoryButton.setTitleColor(.white, for: .normal)
            categoryButton.backgroundColor = .red
        }else {
            resetButtonState()
        }
    }
    
    public func isButtonSelected() -> Bool {
        return categoryButton.backgroundColor == .red
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(categoryButton)
        NSLayoutConstraint.activate([
            categoryButton.topAnchor.constraint(equalTo: topAnchor),
            categoryButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            categoryButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            categoryButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        resetButtonState()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
