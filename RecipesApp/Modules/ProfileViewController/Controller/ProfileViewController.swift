//
//  ProfileViewController.swift
//  RecipesApp
//
//  Created by Андрей Фроленков on 4.09.23.
//

import Foundation
import UIKit

// MARK: - ProfileViewController
class ProfileViewController: UIViewController {
  
  // MARK: - Private Property
  private lazy var tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    tableView.estimatedRowHeight = UITableView.automaticDimension
    tableView.separatorStyle = .none
    tableView.backgroundColor = .white
    tableView.showsVerticalScrollIndicator = false
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  // MARK: - Action Methods
  @objc
  private func buttonTap() {
    print("Tap")
  }
}

// MARK: - Setting Views
private extension ProfileViewController {
  func setupView() {
    view.backgroundColor = UIColor.white
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
    label.textColor = UIColor.neutral100
    label.font = UIFont.poppinsBold24()
    
    switch section {
    case 0:
      label.text = "My profile"
      let editButton = UIButton(type: .system)
      editButton.tintColor = .black
      editButton.setImage(UIImage.init(systemName: "ellipsis"), for: .normal)
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
      return cell
    case 1:
      let cell = tableView.dequeueReusableCell(withIdentifier: MyRecipesCell.identifier, for: indexPath) as! MyRecipesCell
      return cell
    default:
        return UITableViewCell()
    }
  }
  
  
  
}
