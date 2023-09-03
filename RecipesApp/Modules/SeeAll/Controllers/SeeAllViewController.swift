//
//  WelcomeViewController.swift
//  RecipesApp
//
//  Created by Владислав on 28.08.2023.
//

import UIKit

class SeeAllViewController: UIViewController {
    
    
    private lazy var seeAllTableView = SeeAllTableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seeAllTableView.recipeSelectionDelegate = self
        setupUI()
        setupConstraints()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        seeAllTableView.layer.cornerRadius = 30
    }

    private func setupUI() {
        title = "Trending now"
        view.backgroundColor = .systemBackground
        view.addSubview(seeAllTableView)

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


extension SeeAllViewController: SeeAllTableViewDelegate{
    func didSelectRecipe(recipe: Recipe) {
        let detailModel = DetailRecipeModel(nameRecipe: recipe.name, imageRecipe: recipe.image)
        let vc = RecipeDetailViewController(model: detailModel, id: recipe.id)
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}
