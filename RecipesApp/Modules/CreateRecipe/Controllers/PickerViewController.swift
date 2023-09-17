import UIKit

protocol SelectButtonTappedDelegate: NSObject {
    func selectButtonPressed(title: String, pickerType: PickerType)
}

class PickerViewController: UIViewController {
    weak var delegate: SelectButtonTappedDelegate?
    var dataSource: [String]
    var selectedTitle: String = ""
    var pickerType: PickerType
    
    
    private lazy var toolBarView = UIView(backgroundColor: UIColor(named: "categoryColor")!, cornerRadius: 0)
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(name: "Cancel", backgroundColor: nil, font: .systemFont(ofSize: 15), titleColor: UIColor(named: "redBlue"))
        button.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var selectButton: UIButton = {
        let button = UIButton(name: "Select", backgroundColor: nil, font: .systemFont(ofSize: 15), titleColor: UIColor(named: "redBlue"))
        button.addTarget(self, action: #selector(selectButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleToolBar = UILabel(text: "Choose Value", font: .boldSystemFont(ofSize: 15), textColor: UIColor(named: "blackWhite")!, textAligment: .center, numberOfLines: 1)

    

    private lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()

        
    init(dataSource: [String], pickerType: PickerType) {
        self.dataSource = dataSource
        self.pickerType = pickerType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    
    @IBAction func cancelButtonPressed() {
        dismiss(animated: true)
    }
    
    @IBAction func selectButtonPressed() {
        delegate?.selectButtonPressed(title: selectedTitle, pickerType: pickerType)
        dismiss(animated: true)
    }
    
    private func setupUI() {
        toolBarView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(toolBarView)
        toolBarView.addSubview(cancelButton)
        toolBarView.addSubview(titleToolBar)
        toolBarView.addSubview(selectButton)
        view.addSubview(pickerView)
        NSLayoutConstraint.activate([
            toolBarView.topAnchor.constraint(equalTo: view.topAnchor),
            toolBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toolBarView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            cancelButton.centerYAnchor.constraint(equalTo: toolBarView.centerYAnchor),
            cancelButton.leadingAnchor.constraint(equalTo: toolBarView.leadingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            titleToolBar.centerXAnchor.constraint(equalTo: toolBarView.centerXAnchor),
            titleToolBar.centerYAnchor.constraint(equalTo: toolBarView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            selectButton.centerYAnchor.constraint(equalTo: toolBarView.centerYAnchor),
            selectButton.trailingAnchor.constraint(equalTo: toolBarView.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            pickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pickerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    
}


extension PickerViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSource[row]
    }
    
    
}

extension PickerViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        selectedTitle = dataSource[row]
    }
    

}
