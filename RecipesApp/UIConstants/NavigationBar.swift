import UIKit

extension UIViewController {
    func setupNavigationBarWithBackButton() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(goBack))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
        
    }
    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
