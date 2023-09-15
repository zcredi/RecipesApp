import UIKit

// MARK: - ProfileViewController

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: - Private Property
    private var dynamicImage: UIImage = UIImage() {
        didSet{
            updateCellImage()
        }
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemBackground
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "My profile"
        setupView()
    }
    
    // MARK: - Action Methods

    private func updateCellImage() {
        if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? MyProfileCell {
            cell.updatePicture(picture: dynamicImage)
        }
    }

    
    
    @objc
    private func buttonTap(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        let alertController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
      
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
      
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true)
            }
            alertController.addAction(cameraAction)
        }
      
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { _ in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true)
            }
            alertController.addAction(photoLibraryAction)
        }
      
        alertController.popoverPresentationController?.sourceView = sender
        present(alertController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        dynamicImage = selectedImage
        picker.dismiss(animated: true)
    }
    
}

// MARK: - Setting Views

private extension ProfileViewController {
    func setupView() {
        view.backgroundColor = .systemBackground
        addSubviews()
        setupLayout()
        configureTableView()
    }
}

// MARK: - Setting

private extension ProfileViewController {
    func addSubviews() {
        view.addSubview(tableView)
    }
  
    func configureTableView() {
        tableView.register(MyProfileCell.self, forCellReuseIdentifier: MyProfileCell.identifier)
        tableView.register(MyRecipesCell.self, forCellReuseIdentifier: MyRecipesCell.identifier)
    
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - Layuot

private extension ProfileViewController {
    private func setupLayout() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
    
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 3
        default: return 0
        }
    }
  
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        label.textColor = UIColor(named: "blackWhite")!
        label.font = UIFont.poppinsBold24()
    
        switch section {
        case 0:
            label.text = "My profile"
            let editButton = UIButton(type: .system)
            editButton.tintColor = UIColor(named: "blackWhite")!
            editButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
            editButton.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
            let stackView = UIStackView(arrangedSubviews: [label, editButton])
            stackView.spacing = 2
            stackView.distribution = .equalSpacing
            return stackView
        case 1:
            label.text = "My recipes"
            return label
        default:
            return label
        }
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: MyProfileCell.identifier, for: indexPath) as! MyProfileCell
            cell.backgroundColor = .clear
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: MyRecipesCell.identifier, for: indexPath) as! MyRecipesCell
            cell.backgroundColor = .clear
            return cell
        default:
            return UITableViewCell()
        }
    }
}
