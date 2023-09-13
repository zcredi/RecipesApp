import UIKit

class CreateRecipeViewController: UIViewController {
    
    enum Constants {
        static let headerViewTopSpacing: CGFloat = 4.0
        static let headerViewLeadingSpacing: CGFloat = 16.0
    }
    
    //MARK: - Create UI
    
    private lazy var headerView = HeaderView()
    private lazy var cookTimeView = CookTimeView()
    private lazy var footerView = FooterView()
    
    private lazy var createRecipeButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .primary50
        button.layer.cornerRadius = 8
        button.setTitle("Create recipe", for: .normal)
        button.tintColor = .neutral0
        button.titleLabel?.font = .poppinsBold16()
        button.addTarget(self, action: #selector(createRecipeButtonTapped), for: .touchUpInside)
        return button
    }()
        
    //MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Create Recipe"
        setupViews()
        setConstraints()
        setupServesGestures()
        setupCookTimeGestures()
    }

    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubviews(headerView, cookTimeView, footerView, createRecipeButton)
    }
    
    private func setupServesGestures() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(servesTapped))
        tapGesture.numberOfTapsRequired = 1
        headerView.servesButton.addGestureRecognizer(tapGesture)
    }

    @objc
    private func servesTapped() {
        let popVC = ServesTableViewController()
        popVC.delegate = self
            popVC.modalPresentationStyle = .popover
        
        popVC.modalPresentationStyle = .popover
        
        let popOverVC = popVC.popoverPresentationController
        popOverVC?.delegate = self
        popOverVC?.sourceView = headerView.servesButton
        popOverVC?.sourceRect = CGRect(x: headerView.servesButton.bounds.midX, y: headerView.servesButton.bounds.midY, width: 0, height: 0)
        popVC.preferredContentSize = CGSize(width: 250, height: 250)
        
        self.present(popVC, animated: true)
    }
    
    private func setupCookTimeGestures() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cookTimeTapped))
        tapGesture.numberOfTapsRequired = 1
        cookTimeView.cookTimeButton.addGestureRecognizer(tapGesture)
    }

    @objc
    private func cookTimeTapped() {
        let popVC = CookTimeTableViewController()
        popVC.delegate = self
        popVC.modalPresentationStyle = .popover
        
        popVC.modalPresentationStyle = .popover
        
        let popOverVC = popVC.popoverPresentationController
        popOverVC?.delegate = self
        popOverVC?.sourceView = cookTimeView.cookTimeButton
        popOverVC?.sourceRect = CGRect(x: cookTimeView.cookTimeButton.bounds.midX, y: cookTimeView.cookTimeButton.bounds.midY, width: 0, height: 0)
        popVC.preferredContentSize = CGSize(width: 250, height: 250)
        
        self.present(popVC, animated: true)
    }
}

extension CreateRecipeViewController: ServesTableViewControllerDelegate {
    func didSelectServesNumber(_ number: String) {
        headerView.servesNumberLabel.text = number
    }
}

extension CreateRecipeViewController: CookTimeTableViewControllerDelegate {
    func didSelectCookTimeNumber(_ number: String) {
        cookTimeView.timeLabel.text = number
    }
    
    @objc
    private func createRecipeButtonTapped() {
        dismiss(animated: true)
    }
}

//MARK: - setConstraints

extension CreateRecipeViewController {
    private func setConstraints() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.headerViewTopSpacing),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.headerViewLeadingSpacing),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.headerViewLeadingSpacing),
            headerView.heightAnchor.constraint(equalToConstant: 370)
        ])
        
        cookTimeView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cookTimeView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 8),
            cookTimeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.headerViewLeadingSpacing),
            cookTimeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.headerViewLeadingSpacing),
            cookTimeView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        footerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            footerView.topAnchor.constraint(equalTo: cookTimeView.bottomAnchor, constant: 16),
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.headerViewLeadingSpacing),
            footerView.heightAnchor.constraint(equalToConstant: 270)
        ])
        
        createRecipeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createRecipeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            createRecipeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createRecipeButton.heightAnchor.constraint(equalToConstant: 56),
            createRecipeButton.widthAnchor.constraint(equalToConstant: 344)
        ])
    }
}

extension CreateRecipeViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
