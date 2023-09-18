import Foundation
import UIKit

// MARK: - MyProfileCell
protocol ProfileImagePressedDelegate: NSObject {
    func profileImagePressed(_ sender: UIImageView)
}
final class MyProfileCell: UITableViewCell {
    static let identifier = "MyProfileCell"
    weak var delegate: ProfileImagePressedDelegate?
    
    lazy var photoImageView = UIImageView(image: "Christina Tosi", cornerRadius: 50)
    private lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(myProfileImagePressed))
  
    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        setupCell()
        layoutUI()
    }
  
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    // MARK: - Private Methods

    @IBAction func myProfileImagePressed() {
        delegate?.profileImagePressed(photoImageView)
    }
    
    private func setupCell() {
        photoImageView.isUserInteractionEnabled = true
        photoImageView.addGestureRecognizer(tapGesture)
        selectionStyle = .none
        contentView.addSubviews(photoImageView)
    }
  
    // MARK: - Layout

    private func layoutUI() {
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
    
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
      
            photoImageView.heightAnchor.constraint(equalToConstant: 100),
            photoImageView.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    public func updatePicture(picture: UIImage?) {
        self.photoImageView.image = picture
    }
}
