import UIKit

class DiscoverViewController: UIViewController {
    let discoverViewModel = DiscoverViewModel()
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 270
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomViewTableCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Saved Recipe"
        view.addSubview(tableView)
        setupConstrains()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        discoverViewModel.fetchSavedRecipe()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateTableView()
    }
    
    func setupConstrains() {
        tableView.snp.makeConstraints { make in
            make.top.trailing.leading.bottom.equalToSuperview()
        }
    }
    private func animateTableView() {
        tableView.reloadData()
        if !discoverViewModel.savedRecipe.isEmpty{
            let cells = tableView.visibleCells
            let tableViewHeight = tableView.bounds.height
            var delay: Double = 0
            
            for cell in cells {
                cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
                
                UIView.animate(withDuration: 1.5,
                               delay: delay * 0.05,
                               usingSpringWithDamping: 0.8,
                               initialSpringVelocity: 0,
                               options: .curveEaseInOut,
                               animations: {
                    cell.transform = CGAffineTransform.identity
                },completion: nil)
                delay += 1
            }
        }
    }
    
}

extension DiscoverViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return discoverViewModel.savedRecipe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard let newCell = cell as? CustomViewTableCell else {
            return cell
        }
        newCell.selectionStyle = .none
        newCell.createCell(recipe: discoverViewModel.savedRecipe[indexPath.row])
        return newCell
    }
}

extension DiscoverViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentIndexPath = discoverViewModel.savedRecipe[indexPath.row]
        
        
        let vc = RecipeDetailViewController(recipe: currentIndexPath.title, image: currentIndexPath.image, id: currentIndexPath.id)
        navigationController?.pushViewController(vc, animated: true)
    }
}
