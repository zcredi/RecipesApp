//
//  WelcomeViewController.swift
//  RecipesApp
//
//  Created by Владислав on 28.08.2023.
//

import UIKit

class SeeAllViewController: UIViewController {
    
    
    private let seeAllTableView = SeeAllTableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setup()
        setupConstraints()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        seeAllTableView.layer.cornerRadius = 30
    }

    


    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(seeAllTableView)

    }
    
    private func setup() {
        
        
    }
    
    private func setupConstraints() {
        seeAllTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            seeAllTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            seeAllTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            seeAllTableView.topAnchor.constraint(equalTo: view.topAnchor),
            seeAllTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        
        ])
        
    }
}


