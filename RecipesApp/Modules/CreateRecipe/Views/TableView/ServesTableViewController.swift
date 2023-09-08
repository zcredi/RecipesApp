//
//  ServesTableViewController.swift
//  RecipesApp
//
//  Created by Владислав on 06.09.2023.
//

import UIKit

protocol ServesTableViewControllerDelegate: AnyObject {
    func didSelectServesNumber(_ number: String)
}

class ServesTableViewController: UITableViewController {
    
    let servesNumbersArray = ["01", "02", "03", "04", "05"]
    
    weak var delegate: ServesTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "servesCell")
        tableView.isScrollEnabled = false
    }
    
    override func viewWillLayoutSubviews() {
        preferredContentSize = CGSize(width: 70, height: tableView.contentSize.height)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return servesNumbersArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "servesCell", for: indexPath) as! UITableViewCell
        
        let textData = servesNumbersArray[indexPath.row]
        cell.textLabel?.text = textData
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedNumber = servesNumbersArray[indexPath.row]
        delegate?.didSelectServesNumber(selectedNumber)
        dismiss(animated: true, completion: nil)
    }
}
