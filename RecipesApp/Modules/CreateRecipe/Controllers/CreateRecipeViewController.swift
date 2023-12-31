import AlertKit
import UIKit

class CreateRecipeViewController: UIViewController {
    private var createRecipeViewModel = CreateRecipeViewModel()
    private lazy var headerView = HeaderView()
    private lazy var cookTimeView = CookTimeView()
    private lazy var footerView = FooterView()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var createRecipeButton: UIButton = {
        let button = UIButton(name: "Create recipe", backgroundColor: UIColor(named: "redBlue"), font: .poppinsBold16(), titleColor: .white)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(createRecipeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @IBAction private func createRecipeButtonTapped() {
        guard let recipeName = headerView.recipeNameTextField.text, !recipeName.isEmpty,
              let image = headerView.recipeImage.image,
              let cookTime = cookTimeView.timeLabel.text,
              !footerView.ingredientsArray.isEmpty
        else {
            errorAlert()
            return
        }
        self.createRecipeViewModel.saveRecipe(image: image, title: recipeName, cookTime: cookTime, ingredients: footerView.ingredientsArray)
        completeAlert()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Create Recipe"
        setupNavigationBarWithBackButton()
        setupUI()
        subcribeDelegate()
    }
    
    private func subcribeDelegate() {
        headerView.delegate = self
        headerView.imageDelegate = self
        cookTimeView.delegate = self
    }
    
    private func completeAlert() {
        AlertKitAPI.present(title: "Complete", subtitle: "You've created your recipe!", icon: .done, style: .iOS16AppleMusic, haptic: .success)
    }
    
    private func errorAlert() {
        AlertKitAPI.present(title: "Error", subtitle: "You have not entered all the required parameters for creating a recipe", icon: .error, style: .iOS16AppleMusic, haptic: .error)
    }
}

// MARK: - setConstraints

extension CreateRecipeViewController {
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubviews(headerView, cookTimeView, footerView, createRecipeButton)
        
        // Setup constraints for scrollView
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 15.0, *) {
            NSLayoutConstraint.activate([
                scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor)
            ])
        }
        // Setup constraints for headerView
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 4),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            headerView.heightAnchor.constraint(equalToConstant: 370)
        ])

        // Setup constraints for cookTimeView
        cookTimeView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cookTimeView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 5),
            cookTimeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cookTimeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            cookTimeView.heightAnchor.constraint(equalToConstant: 60)
        ])

        // Setup constraints for footerView
        footerView.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 15.0, *) {
            NSLayoutConstraint.activate([
                footerView.topAnchor.constraint(equalTo: cookTimeView.bottomAnchor, constant: 16),
                footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                footerView.heightAnchor.constraint(equalToConstant: 200),
                
            ])
        }

        // Setup constraints for createRecipeButton
        createRecipeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createRecipeButton.topAnchor.constraint(equalTo: footerView.bottomAnchor, constant: 10),
            createRecipeButton.widthAnchor.constraint(equalToConstant: 350),
            createRecipeButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            createRecipeButton.heightAnchor.constraint(equalToConstant: 50),
            createRecipeButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10)
        ])
    }
}


extension CreateRecipeViewController: ServesButtonPressedDelegate {
    func servesButtonPressed(_ sender: UIButton) {
        let viewControllerToPresent = PickerViewController(dataSource: createRecipeViewModel.servesCount, pickerType: .serves)
        viewControllerToPresent.delegate = self
        viewControllerToPresent.isModalInPresentation = true
        if #available(iOS 15.0, *) {
            if let sheet = viewControllerToPresent.sheetPresentationController {
                sheet.detents = [.medium()]
            }
        }
        present(viewControllerToPresent, animated: true)
    }
}

extension CreateRecipeViewController: CookTimeButtonPressedDelegate {
    func cookTimeButtonPressed(_ sender: UIButton) {
        let viewControllerToPresent = PickerViewController(dataSource: createRecipeViewModel.cookTime, pickerType: .cookTime)
        viewControllerToPresent.delegate = self
        viewControllerToPresent.isModalInPresentation = true
        if #available(iOS 15.0, *) {
            if let sheet = viewControllerToPresent.sheetPresentationController {
                sheet.detents = [.medium()]
            }
        }
        present(viewControllerToPresent, animated: true)
    }
}

extension CreateRecipeViewController: SelectButtonTappedDelegate {
    func selectButtonPressed(title: String, pickerType: PickerType) {
        switch pickerType {
            case .serves: headerView.servesNumberLabel.text = title
            case .cookTime: cookTimeView.timeLabel.text = title
        }
    }
}

extension CreateRecipeViewController: RecipeImagePressedDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func recipeImagePressed(_ sender: UIImageView) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        let alertController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { [weak self] _ in
                imagePicker.sourceType = .camera
                self?.present(imagePicker, animated: true)
            }
            alertController.addAction(cameraAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { [weak self] _ in
                imagePicker.sourceType = .photoLibrary
                self?.present(imagePicker, animated: true)
            }
            alertController.addAction(photoLibraryAction)
        }
        
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = sender
            popoverController.sourceRect = sender.bounds
        }
        
        present(alertController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        headerView.recipeImage.image = selectedImage
        picker.dismiss(animated: true)
    }
}
