
import UIKit

class CookTimeView: UIView {
    private lazy var cookTimeView = UIView(backgroundColor: UIColor(named: "categoryColor")!, cornerRadius: 12)
    private lazy var clockView = UIView(backgroundColor: .systemBackground, cornerRadius: 10)
    private lazy var cookTimeLabel = UILabel(text: "Cook time", font: .poppinsBold16(), textColor: UIColor(named: "blackWhite")!, numberOfLines: 1)
    public lazy var timeLabel = UILabel(text: "5 min", font: .poppinsRegular14(), textColor: UIColor(named: "blackWhite")!, numberOfLines: 1)
    
    private lazy var timeImageView: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "clock.fill")?.withTintColor(UIColor(named: "blackWhite")!, renderingMode: .alwaysOriginal))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    public lazy var cookTimeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.tintColor = UIColor(named: "blackWhite")!
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(cookTimeView)
        cookTimeView.addSubviews(clockView, cookTimeLabel, cookTimeButton, timeLabel)
        clockView.addSubview(timeImageView)
    }

}

extension CookTimeView: CookTimeTableViewControllerDelegate {
    func didSelectCookTimeNumber(_ number: String) {
        timeLabel.text = number
    }
}

extension CookTimeView {
    private func setConstraints() {
        cookTimeView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cookTimeView.topAnchor.constraint(equalTo: topAnchor),
            cookTimeView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            cookTimeView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            cookTimeView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        clockView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            clockView.centerYAnchor.constraint(equalTo: cookTimeView.centerYAnchor),
            clockView.leadingAnchor.constraint(equalTo: cookTimeView.leadingAnchor, constant: 16),
            clockView.widthAnchor.constraint(equalToConstant: 36),
            clockView.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        timeImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeImageView.centerYAnchor.constraint(equalTo: clockView.centerYAnchor),
            timeImageView.centerXAnchor.constraint(equalTo: clockView.centerXAnchor),
            timeImageView.heightAnchor.constraint(equalToConstant: 18)
        ])
        
        cookTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cookTimeLabel.centerYAnchor.constraint(equalTo: cookTimeView.centerYAnchor),
            cookTimeLabel.leadingAnchor.constraint(equalTo: clockView.trailingAnchor, constant: 15)
        ])
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeLabel.centerYAnchor.constraint(equalTo: cookTimeView.centerYAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: cookTimeButton.leadingAnchor, constant: -10)
        ])
        
        cookTimeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cookTimeButton.centerYAnchor.constraint(equalTo: cookTimeView.centerYAnchor),
            cookTimeButton.trailingAnchor.constraint(equalTo: cookTimeView.trailingAnchor, constant: -15)
        ])
    }
}
