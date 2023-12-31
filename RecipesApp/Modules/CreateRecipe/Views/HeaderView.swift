import UIKit

protocol ServesButtonPressedDelegate: NSObject {
    func servesButtonPressed(_ sender: UIButton)
}

protocol RecipeImagePressedDelegate: NSObject {
    func recipeImagePressed(_ sender: UIImageView)
}

class HeaderView: UIView {
    
    weak var delegate: ServesButtonPressedDelegate?
    weak var imageDelegate: RecipeImagePressedDelegate?
    
    lazy var recipeImage: UIImageView = {
        let image = UIImageView(image: "mealImage", cornerRadius: 10)
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(tapGesture)
        return image
    }()
    
    private lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(imagePressed))
    lazy var recipeNameTextField = CreateRecipeTextField()
    private lazy var servesView = UIView(backgroundColor: UIColor(named: "categoryColor")!, cornerRadius: 12)
    private lazy var personView = UIView(backgroundColor: .systemBackground, cornerRadius: 10)
    
    private lazy var usersImageView: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "person.2.fill")?.withTintColor(UIColor(named: "blackWhite")!, renderingMode: .alwaysOriginal))
        image.contentMode = .center
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var servesLabel = UILabel(text: "Serves", font: .poppinsBold16(), textColor: UIColor(named: "blackWhite")!, numberOfLines: 1)
    
    public lazy var servesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.tintColor = UIColor(named: "blackWhite")!
        button.addTarget(self, action: #selector(arrowRightButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    public lazy var servesNumberLabel = UILabel(text: "01", font: .poppinsRegular14(), textColor: UIColor(named: "blackWhite")!, numberOfLines: 1)
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func imagePressed() {
        imageDelegate?.recipeImagePressed(recipeImage)
        print("Image Pressed!")
    }
    
    @IBAction func arrowRightButtonPressed(_ sender: UIButton) {
        delegate?.servesButtonPressed(sender)
    }
    
    private func setupViews() {
        addSubviews(recipeImage, recipeNameTextField, servesView)
        servesView.addSubviews(personView, servesLabel, servesButton, servesNumberLabel)
        personView.addSubview(usersImageView)
    }
}

//MARK: - setConstraints
extension HeaderView {
    private func setConstraints() {
        recipeImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recipeImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            recipeImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            recipeImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            recipeImage.heightAnchor.constraint(equalToConstant: 200),
        ])
        recipeNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recipeNameTextField.topAnchor.constraint(equalTo: recipeImage.bottomAnchor, constant: 20),
            recipeNameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            recipeNameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            recipeNameTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        servesView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            servesView.topAnchor.constraint(equalTo: recipeNameTextField.bottomAnchor, constant: 30),
            servesView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            servesView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            servesView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        personView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            personView.centerYAnchor.constraint(equalTo: servesView.centerYAnchor),
            personView.leadingAnchor.constraint(equalTo: servesView.leadingAnchor, constant: 16),
            personView.widthAnchor.constraint(equalToConstant: 36),
            personView.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        NSLayoutConstraint.activate([
            usersImageView.centerYAnchor.constraint(equalTo: personView.centerYAnchor),
            usersImageView.centerXAnchor.constraint(equalTo: personView.centerXAnchor),
            usersImageView.heightAnchor.constraint(equalToConstant: 18)
        ])
        
        NSLayoutConstraint.activate([
            servesLabel.centerYAnchor.constraint(equalTo: servesView.centerYAnchor),
            servesLabel.leadingAnchor.constraint(equalTo: personView.trailingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            servesNumberLabel.centerYAnchor.constraint(equalTo: servesView.centerYAnchor),
            servesNumberLabel.trailingAnchor.constraint(equalTo: servesButton.leadingAnchor, constant: -8)
        ])
        
        servesButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            servesButton.centerYAnchor.constraint(equalTo: servesView.centerYAnchor),
            servesButton.trailingAnchor.constraint(equalTo: servesView.trailingAnchor, constant: -16)
        ])
    }
}
