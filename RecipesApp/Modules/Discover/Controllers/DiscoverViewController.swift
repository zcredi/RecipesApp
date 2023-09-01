//
//  DiscoverViewController.swift
//  RecipesApp
//
//  Created by Владислав on 28.08.2023.
//

import UIKit
import SnapKit

class DiscoverViewController: UIViewController {
var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTable()
        setupConstrains()
        view.addSubview(tableView)
    }

}

extension DiscoverViewController:  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard let newCell = cell as? CustomViewTableCell else {
            return cell
        }
        newCell.createCell(recipeimage: UIImage(systemName: "studentdesk")!,
                           recipeTitle: String("Recipe title \(indexPath.row)"),
                           authorImage: UIImage(systemName: "person.circle.fill")!,
                           labelRating: String(indexPath.row),
                           authorlabel: "Author name \(indexPath.row)",
                           cookingTime: "10",
                           isFavoring: true)
        return newCell
    }
    
    func createTable() {
        view.addSubview(tableView)
        tableView.register(CustomViewTableCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 260
    }
    func setupConstrains() {
        
        tableView.snp.makeConstraints { make in
      
            make.top.trailing.leading.bottom.equalToSuperview()
            
        }
    }
}
