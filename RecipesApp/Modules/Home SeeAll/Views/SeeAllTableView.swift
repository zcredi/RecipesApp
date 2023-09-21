import UIKit

class SeeAllTableView: UITableView {
    var seeAllViewModel: SeeAllViewModel? {
        didSet {
            guard let viewModel = seeAllViewModel else { return }
            self.reloadData()
        }
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.layer.cornerRadius = 30
        seeAllViewModel?.fetchTrendingNow {
            self.configureTable()
            self.reloadData()
        }
    }
    
    func configureTable() {
        backgroundColor = .white
        separatorStyle = .none
        register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        dataSource = self
        delegate = self
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - TableView Delegate

extension SeeAllTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seeAllViewModel?.trendingNow.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell,
              let recipe = seeAllViewModel?.trendingNow[indexPath.row]
        else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.configure(withModelRecipe: recipe)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let currentIndexPath = seeAllViewModel?.trendingNow[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
}
