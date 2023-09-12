
import UIKit

class CookTimeView: UIView {
    
    private lazy var backViewCookTime = UIView(backgroundColor: .neutral10, cornerRadius: 12)
    
    private lazy var whiteViewCookTime = UIView(backgroundColor: .neutral0, cornerRadius: 10)
    
    private lazy var timeImageView = UIImageView(image: "clock", cornerRadius: 0)
    
    private lazy var cookTimeLabel = UILabel(text: "Cook time", font: .poppinsBold16(), textColor: .neutral100, numberOfLines: 1)
    
    public lazy var cookTimeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.tintColor = .neutral100
        return button
    }()
    
    public lazy var timeLabel = UILabel(text: "5 min", font: .poppinsRegular14(), textColor: .neutral50, numberOfLines: 1)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(backViewCookTime)
        backViewCookTime.addSubviews(whiteViewCookTime, cookTimeLabel, cookTimeButton, timeLabel)
        whiteViewCookTime.addSubview(timeImageView)
    }

}

extension CookTimeView: CookTimeTableViewControllerDelegate {
    func didSelectCookTimeNumber(_ number: String) {
        timeLabel.text = number
    }
}

extension CookTimeView {
    private func setConstraints() {
        backViewCookTime.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backViewCookTime.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            backViewCookTime.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            backViewCookTime.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            backViewCookTime.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        whiteViewCookTime.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            whiteViewCookTime.centerYAnchor.constraint(equalTo: backViewCookTime.centerYAnchor),
            whiteViewCookTime.leadingAnchor.constraint(equalTo: backViewCookTime.leadingAnchor, constant: 16),
            whiteViewCookTime.widthAnchor.constraint(equalToConstant: 36),
            whiteViewCookTime.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        timeImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeImageView.centerYAnchor.constraint(equalTo: whiteViewCookTime.centerYAnchor),
            timeImageView.centerXAnchor.constraint(equalTo: whiteViewCookTime.centerXAnchor),
            timeImageView.heightAnchor.constraint(equalToConstant: 18)
        ])
        
        cookTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cookTimeLabel.centerYAnchor.constraint(equalTo: backViewCookTime.centerYAnchor),
            cookTimeLabel.leadingAnchor.constraint(equalTo: whiteViewCookTime.trailingAnchor, constant: 16)
        ])
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeLabel.centerYAnchor.constraint(equalTo: backViewCookTime.centerYAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: cookTimeButton.leadingAnchor, constant: -8)
        ])
        
        cookTimeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cookTimeButton.centerYAnchor.constraint(equalTo: backViewCookTime.centerYAnchor),
            cookTimeButton.trailingAnchor.constraint(equalTo: backViewCookTime.trailingAnchor, constant: -16)
        ])
    }
}
