import UIKit

class PopularCreatorsCollectionViewCell: UICollectionViewCell {
    static let identifier = "PopularCreatorsCell"
    
    private lazy var creatorImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "sex"))
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 60
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var creatorLabel: UILabel = {
        let label = UILabel(text: "Ify’s Kitchen", font: UIFont.poppinsBold12(), textColor: .black)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(creatorImage)
        contentView.addSubview(creatorLabel)
        
        NSLayoutConstraint.activate([
            creatorImage.heightAnchor.constraint(equalToConstant: 120),
            creatorImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            creatorImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            creatorImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            
            creatorLabel.topAnchor.constraint(equalTo: creatorImage.bottomAnchor, constant: 10),
            creatorLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    public func configureCell(with creator: String){
        creatorImage.image = UIImage(named: creator)
        creatorLabel.text = creator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
