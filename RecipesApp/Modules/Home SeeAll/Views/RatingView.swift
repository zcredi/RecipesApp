import UIKit

class RatingView: UIView {
    private lazy var blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.contentMode = .scaleAspectFill
        blurredEffectView.layer.opacity = 0.4
        blurredEffectView.translatesAutoresizingMaskIntoConstraints = false
        return blurredEffectView
    }()
    
    
    private lazy var ratingLabel = UILabel(text: "5.0", font: .boldSystemFont(ofSize: 16), textColor: .white, textAligment: .left, numberOfLines: 0)
        
    
    private lazy var starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubviews(blurView, starImageView, ratingLabel)
    }
    
    func setupConstraints() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: topAnchor),
            blurView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            starImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            starImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            starImageView.heightAnchor.constraint(equalToConstant: 16),
            starImageView.widthAnchor.constraint(equalToConstant: 16),
            
            ratingLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
            
        ])
    }
}
