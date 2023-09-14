import UIKit
import SnapKit
import Kingfisher

class CustomViewTableCell: UITableViewCell {
    private let recipeImage = UIImageView(image: "recipeImage", cornerRadius: 15)
    private let authorImage = UIImageView(image: "recipeImage", cornerRadius: 15)
    private let recipeNameLabel = UILabel(text: "Pirogi s glazami", font: .poppinsBold16(), textColor: .label, numberOfLines: 2)
    private let authorNameLabel = UILabel(text: "Name", font: UIFont.poppinsRegular12(), textColor: .neutral50, numberOfLines: 0)
    
    private func setViews() {
        addSubviews(recipeImage, authorImage, authorNameLabel, recipeNameLabel)
    }
    
    private func setupConstraines() {
        recipeImage.snp.makeConstraints { make in
            make.height.equalTo(180)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalToSuperview().offset(10)
        }
        
        recipeNameLabel.snp.makeConstraints { make in
            make.height.equalTo(22)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(recipeImage.snp.bottom).offset(10)
        }
        authorImage.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.width.equalTo(32)
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(recipeNameLabel.snp.bottom).offset(5)
        }
        authorNameLabel.snp.makeConstraints { make in
            make.height.equalTo(18)
            make.leading.equalTo(authorImage.snp.trailing).offset(7)
            make.centerY.equalTo(authorImage.snp.centerY)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "reuseIdentifier")
        setViews()
        setupConstraines()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension CustomViewTableCell {
    func createCell(recipe: SavedRecipeModel){
        guard let url = URL(string: recipe.image) else { return }
        recipeImage.kf.setImage(with: url)
        recipeNameLabel.text = recipe.title
    }
}
