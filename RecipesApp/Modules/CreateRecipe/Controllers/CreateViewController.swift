import UIKit

class CreateViewController: UIViewController {
    
    private lazy var createRecipeImage = UIImageView(image: "createRecipe", cornerRadius: 12)
    private lazy var createRecipeButton: UIButton = {
        let button = UIButton(name: "Create your custom recipe", backgroundColor: UIColor(named: "redBlue"), font: .boldSystemFont(ofSize: 20), titleColor: .white)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(createRecipeButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Create recipe"
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    
    @IBAction func createRecipeButtonPressed(_ sender: UIButton) {
        print("Create recipe button pressed!!!")
        let vc = CreateRecipeViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupUI() {
        view.addSubviews(createRecipeImage, createRecipeButton)
        
        NSLayoutConstraint.activate([
            createRecipeImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            createRecipeImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            createRecipeImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            createRecipeImage.heightAnchor.constraint(equalToConstant: 300),
            
            
            createRecipeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            createRecipeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            createRecipeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            createRecipeButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
}
