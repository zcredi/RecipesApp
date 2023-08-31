//
//  SeeAllTableView.swift
//  RecipesApp
//
//  Created by Elshad Babaev on 30.08.2023.
//

import UIKit

class SeeAllTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        configureTable()
    }
    
    func configureTable() {
        backgroundColor = .clear
        register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        dataSource = self
        delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: - TableView Delegate
extension SeeAllTableView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
