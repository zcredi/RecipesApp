import UIKit

protocol SwitchPopularCategoryCellDelegate: NSObject {
    func didTapButton(in cell: SwitchPopularCategoryCollectionViewCell)
}

class SwitchPopularCategoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SwitchPopularCategoryCollectionViewCell"
    weak var delegate: SwitchPopularCategoryCellDelegate?
    
    private lazy var categoryButton: UIButton = {
        let button = UIButton(name: "", backgroundColor: UIColor(named: "whiteBlack"), font: .poppinsRegular14(), titleColor: UIColor(named: "redBlue"))
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(categoryButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    @IBAction func categoryButtonPressed(_ sender: UIButton) {
        delegate?.didTapButton(in: self)
    }
    
    public func configureCell(with category: String) {
        categoryButton.setTitle(category, for: .normal)
    }
    
    public func resetButtonState(){
        categoryButton.setTitleColor(UIColor(named: "redBlue"), for: .normal)
        categoryButton.backgroundColor = UIColor(named: "whiteBlack")
    }
    
    public func toggleButtonState(){
        if categoryButton.backgroundColor == UIColor(named: "whiteBlack"){
            categoryButton.setTitleColor(.white, for: .normal)
            categoryButton.backgroundColor = UIColor(named: "redBlue")
        }else {
            resetButtonState()
        }
    }
    
    public func isButtonSelected() -> Bool {
        return categoryButton.backgroundColor == UIColor(named: "redBlue")
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
