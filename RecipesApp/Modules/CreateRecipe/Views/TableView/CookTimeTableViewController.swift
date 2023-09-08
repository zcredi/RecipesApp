//
//  CookTimeTableViewController.swift
//  RecipesApp
//
//  Created by Владислав on 06.09.2023.
//

import UIKit

protocol CookTimeTableViewControllerDelegate: AnyObject {
    func didSelectCookTimeNumber(_ number: String)
}

class CookTimeTableViewController: UITableViewController {
    
    let сookTimeNumbersArray = ["5 min",
                                "10 min",
                                "15 min",
                                "20 min",
                                "25 min"]
    
    weak var delegate: CookTimeTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CookTimeCell")
        tableView.isScrollEnabled = false
    }
    
    override func viewWillLayoutSubviews() {
        preferredContentSize = CGSize(width: 100, height: tableView.contentSize.height)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return сookTimeNumbersArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CookTimeCell", for: indexPath) as! UITableViewCell
        
        let textData = сookTimeNumbersArray[indexPath.row]
        cell.textLabel?.text = textData
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedNumber = сookTimeNumbersArray[indexPath.row]
        delegate?.didSelectCookTimeNumber(selectedNumber)
        dismiss(animated: true, completion: nil)
    }
}
