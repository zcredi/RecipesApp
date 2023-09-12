import UIKit

class PopularCreatorsCollectionViewCell: UICollectionViewCell {
    static let identifier = "PopularCreatorsCell"
    
    private lazy var creatorImage = UIImageView(image: "sex", cornerRadius: 60)
    private lazy var creatorLabel = UILabel(text: "Ify’s Kitchen", font: UIFont.poppinsBold12(), textColor: .black, numberOfLines: 1)
    
    public func configureCell(with creator: String){
        creatorImage.image = UIImage(named: creator)
        creatorLabel.text = creator
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(creatorImage, creatorLabel)
        
        NSLayoutConstraint.activate([
            creatorImage.heightAnchor.constraint(equalToConstant: 120),
            creatorImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            creatorImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            creatorImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            
            creatorLabel.topAnchor.constraint(equalTo: creatorImage.bottomAnchor, constant: 10),
            creatorLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
