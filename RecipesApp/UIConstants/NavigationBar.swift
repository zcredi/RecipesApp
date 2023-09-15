import UIKit

extension UIViewController {
    func setupNavigationBarWithBackButton() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(goBack))
        backButton.tintColor = UIColor(named: "blackWhite")
        navigationItem.leftBarButtonItem = backButton
    }
    
    @IBAction private func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
