import UIKit

extension HomeViewController {
    
    func importantUIDownload(){
        if viewModel.recentRecipes.isEmpty && !uiSetupCompleted {
            setupUIWithoutRecentRecipe()
            uiSetupCompleted = true
        }else if !viewModel.recentRecipes.isEmpty && !uiSetupCompleted{
            setupAllUI()
            uiSetupCompleted = true
        }
        
        if uiSetupCompleted {
            if !viewModel.recentRecipes.isEmpty {
                setupAllUI()
                recentRecipeCollectionView.reloadData()
            }
        }
    }
    
    
    func setupAllUI() {
        deactivateAllConstraints(for: view)
        view.addSubview(homeScrollView)
        homeScrollView.addSubviews(trendingNowLabel, seeAllButton, trendingNowCollectionView, popularCategoryLabel, popularCategoryTagCollectionView, popularCategoryCollectionView, recentRecipeLabel, recentRecipeCollectionView, popularCreatorsLabel, popularCreatorsCollectionView)
        
        NSLayoutConstraint.activate([
            homeScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            homeScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            trendingNowLabel.topAnchor.constraint(equalTo: homeScrollView.topAnchor, constant: 10),
            trendingNowLabel.leadingAnchor.constraint(equalTo: homeScrollView.leadingAnchor, constant: 15),
            
            seeAllButton.topAnchor.constraint(equalTo: homeScrollView.topAnchor, constant: 10),
            seeAllButton.trailingAnchor.constraint(equalTo: homeScrollView.trailingAnchor, constant: -15),
            
            trendingNowCollectionView.topAnchor.constraint(equalTo: homeScrollView.topAnchor, constant: 50),
            trendingNowCollectionView.leadingAnchor.constraint(equalTo: homeScrollView.leadingAnchor),
            trendingNowCollectionView.trailingAnchor.constraint(equalTo: homeScrollView.trailingAnchor),
            trendingNowCollectionView.widthAnchor.constraint(equalTo: homeScrollView.widthAnchor),
            trendingNowCollectionView.heightAnchor.constraint(equalToConstant: 260),
            
            popularCategoryLabel.topAnchor.constraint(equalTo: trendingNowCollectionView.bottomAnchor, constant: 30),
            popularCategoryLabel.leadingAnchor.constraint(equalTo: homeScrollView.leadingAnchor, constant: 15),
            
            popularCategoryTagCollectionView.topAnchor.constraint(equalTo: popularCategoryLabel.bottomAnchor, constant: 20),
            popularCategoryTagCollectionView.leadingAnchor.constraint(equalTo: homeScrollView.leadingAnchor),
            popularCategoryTagCollectionView.trailingAnchor.constraint(equalTo: homeScrollView.trailingAnchor),
            popularCategoryTagCollectionView.widthAnchor.constraint(equalTo: homeScrollView.widthAnchor),
            popularCategoryTagCollectionView.heightAnchor.constraint(equalToConstant: 40),
            
            popularCategoryCollectionView.topAnchor.constraint(equalTo: popularCategoryTagCollectionView.bottomAnchor, constant: 20),
            popularCategoryCollectionView.leadingAnchor.constraint(equalTo: homeScrollView.leadingAnchor),
            popularCategoryCollectionView.trailingAnchor.constraint(equalTo: homeScrollView.trailingAnchor),
            popularCategoryCollectionView.widthAnchor.constraint(equalTo: homeScrollView.widthAnchor),
            popularCategoryCollectionView.heightAnchor.constraint(equalToConstant: 300),
            
            
            
            recentRecipeLabel.topAnchor.constraint(equalTo: popularCategoryCollectionView.bottomAnchor, constant: 20),
            recentRecipeLabel.leadingAnchor.constraint(equalTo: homeScrollView.leadingAnchor, constant: 15),
                
            recentRecipeCollectionView.topAnchor.constraint(equalTo: recentRecipeLabel.bottomAnchor, constant: 10),
            recentRecipeCollectionView.leadingAnchor.constraint(equalTo: homeScrollView.leadingAnchor),
            recentRecipeCollectionView.trailingAnchor.constraint(equalTo: homeScrollView.trailingAnchor),
            recentRecipeCollectionView.widthAnchor.constraint(equalTo: homeScrollView.widthAnchor),
            recentRecipeCollectionView.heightAnchor.constraint(equalToConstant: 300),
                
            popularCreatorsLabel.topAnchor.constraint(equalTo: recentRecipeCollectionView.bottomAnchor, constant: 20),
            popularCreatorsLabel.leadingAnchor.constraint(equalTo: homeScrollView.leadingAnchor, constant: 15),
                
            popularCreatorsCollectionView.topAnchor.constraint(equalTo: popularCreatorsLabel.bottomAnchor, constant: 10),
            popularCreatorsCollectionView.leadingAnchor.constraint(equalTo: homeScrollView.leadingAnchor),
            popularCreatorsCollectionView.trailingAnchor.constraint(equalTo: homeScrollView.trailingAnchor),
            popularCreatorsCollectionView.widthAnchor.constraint(equalTo: homeScrollView.widthAnchor),
            popularCreatorsCollectionView.heightAnchor.constraint(equalToConstant: 200),
            popularCreatorsCollectionView.bottomAnchor.constraint(equalTo: homeScrollView.bottomAnchor, constant: -20)
            
        ])
    }
    
    func setupUIWithoutRecentRecipe(){
        deactivateAllConstraints(for: view)
        view.addSubview(homeScrollView)
        homeScrollView.addSubviews(trendingNowLabel, seeAllButton, trendingNowCollectionView, popularCategoryLabel, popularCategoryTagCollectionView, popularCategoryCollectionView, popularCreatorsLabel, popularCreatorsCollectionView)
        
        NSLayoutConstraint.activate([
            homeScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            homeScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            homeScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            homeScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            trendingNowLabel.topAnchor.constraint(equalTo: homeScrollView.topAnchor, constant: 10),
            trendingNowLabel.leadingAnchor.constraint(equalTo: homeScrollView.leadingAnchor, constant: 15),
            
            seeAllButton.topAnchor.constraint(equalTo: homeScrollView.topAnchor, constant: 10),
            seeAllButton.trailingAnchor.constraint(equalTo: homeScrollView.trailingAnchor, constant: -15),
            
            trendingNowCollectionView.topAnchor.constraint(equalTo: homeScrollView.topAnchor, constant: 50),
            trendingNowCollectionView.leadingAnchor.constraint(equalTo: homeScrollView.leadingAnchor),
            trendingNowCollectionView.trailingAnchor.constraint(equalTo: homeScrollView.trailingAnchor),
            trendingNowCollectionView.widthAnchor.constraint(equalTo: homeScrollView.widthAnchor),
            trendingNowCollectionView.heightAnchor.constraint(equalToConstant: 260),
            
            popularCategoryLabel.topAnchor.constraint(equalTo: trendingNowCollectionView.bottomAnchor, constant: 30),
            popularCategoryLabel.leadingAnchor.constraint(equalTo: homeScrollView.leadingAnchor, constant: 15),
            
            popularCategoryTagCollectionView.topAnchor.constraint(equalTo: popularCategoryLabel.bottomAnchor, constant: 20),
            popularCategoryTagCollectionView.leadingAnchor.constraint(equalTo: homeScrollView.leadingAnchor),
            popularCategoryTagCollectionView.trailingAnchor.constraint(equalTo: homeScrollView.trailingAnchor),
            popularCategoryTagCollectionView.widthAnchor.constraint(equalTo: homeScrollView.widthAnchor),
            popularCategoryTagCollectionView.heightAnchor.constraint(equalToConstant: 40),
            
            popularCategoryCollectionView.topAnchor.constraint(equalTo: popularCategoryTagCollectionView.bottomAnchor, constant: 20),
            popularCategoryCollectionView.leadingAnchor.constraint(equalTo: homeScrollView.leadingAnchor),
            popularCategoryCollectionView.trailingAnchor.constraint(equalTo: homeScrollView.trailingAnchor),
            popularCategoryCollectionView.widthAnchor.constraint(equalTo: homeScrollView.widthAnchor),
            popularCategoryCollectionView.heightAnchor.constraint(equalToConstant: 300),
            
                
            popularCreatorsLabel.topAnchor.constraint(equalTo: popularCategoryCollectionView.bottomAnchor, constant: 20),
            popularCreatorsLabel.leadingAnchor.constraint(equalTo: homeScrollView.leadingAnchor, constant: 15),
                
            popularCreatorsCollectionView.topAnchor.constraint(equalTo: popularCreatorsLabel.bottomAnchor, constant: 10),
            popularCreatorsCollectionView.leadingAnchor.constraint(equalTo: homeScrollView.leadingAnchor),
            popularCreatorsCollectionView.trailingAnchor.constraint(equalTo: homeScrollView.trailingAnchor),
            popularCreatorsCollectionView.widthAnchor.constraint(equalTo: homeScrollView.widthAnchor),
            popularCreatorsCollectionView.heightAnchor.constraint(equalToConstant: 200),
            popularCreatorsCollectionView.bottomAnchor.constraint(equalTo: homeScrollView.bottomAnchor, constant: -20)
        ])
    }
    
    func deactivateAllConstraints(for view: UIView) {
        view.removeConstraints(view.constraints)
        for subview in view.subviews {
            subview.removeConstraints(subview.constraints)
        }
    }
}
