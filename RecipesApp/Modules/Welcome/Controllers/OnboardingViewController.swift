import UIKit

class OnboardingViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var pages = [UIViewController]()
    let initialPage = 0
    
    lazy var pageControl: UIPageControl = {
        let pageControlView = UIPageControl()
        pageControlView.translatesAutoresizingMaskIntoConstraints = false
        pageControlView.numberOfPages = self.pages.count
        pageControlView.currentPage = initialPage
        pageControlView.preferredIndicatorImage = UIImage(named: "default")
        pageControlView.currentPageIndicatorTintColor = .primary30
        pageControlView.pageIndicatorTintColor = .neutral20
        return pageControlView
    }()
    
    lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue", for: .normal)
        button.backgroundColor = .primary50
        button.titleLabel?.font = .poppinsRegular20()
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handlerContinueButton), for: .touchUpInside)
        return button
    }()
    
    lazy var skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Skip", for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = .poppinsRegular10()
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSkipButton), for: .touchUpInside)
        return button
    }()
    
    lazy var bottomStack: UIStackView = {
        let buttonsStackView = UIStackView(arrangedSubviews: [continueButton, skipButton])
        buttonsStackView.axis = .vertical
        buttonsStackView.spacing = 12
        
        let bottomStackView = UIStackView(arrangedSubviews: [pageControl, buttonsStackView])
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.axis = .vertical
        bottomStackView.spacing = 31
        bottomStackView.distribution = .fillEqually
        return bottomStackView
    }()
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handlerContinueButton() {
        if continueButton.currentTitle == "Continue" {
            print("handleContinueButton")
            continueAction()
        } else {
            print("startCookingButton")
            startAction()
        }
    }
    
    func continueAction() {
        if pageControl.currentPage == pages.count - 2 {
            continueButton.setTitle("Start Cooking", for: .normal)
            pageControl.currentPage += 1
        } else {
            pageControl.currentPage += 1
        }
        setViewControllers([pages[pageControl.currentPage]], direction: .forward, animated: true)
    }
    
    func startAction() {
        let vc = AuthorizationViewController()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        show(vc, sender: self)
    }
    
    @objc func handleSkipButton() {
        let vc = AuthorizationViewController()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        show(vc, sender: self)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.pages.firstIndex(of: viewController) {
            if viewControllerIndex > 0 {
                continueButton.setTitle("Continue", for: .normal)
                return self.pages[viewControllerIndex - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.pages.firstIndex(of: viewController) {
            if viewControllerIndex < self.pages.count - 1 {
                continueButton.setTitle("Continue", for: .normal)
                return self.pages[viewControllerIndex + 1]
            } else {
                continueButton.setTitle("Start Cooking", for: .normal)
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let viewControllers = pageViewController.viewControllers {
            if let viewControllerIndex = self.pages.firstIndex(of: viewControllers[0]) {
                self.pageControl.currentPage = viewControllerIndex
            }
        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        
        let page1 = PagesViewController(imageName: "Onboarding Page-1", titleTextFirstPart: "Recipes from all", titleTextSecondPart: "over the World", subtitleText: "")
        let page2 = PagesViewController(imageName: "Onboarding Page-2", titleTextFirstPart: "Recipes with", titleTextSecondPart: "each and every detail", subtitleText: "")
        let page3 = PagesViewController(imageName: "Onboarding Page-3", titleTextFirstPart: "Cook it now or", titleTextSecondPart: "save it for later", subtitleText: "")
        
        self.pages.append(contentsOf: [page1, page2, page3])
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
        
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(bottomStack)
        NSLayoutConstraint.activate([
            bottomStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bottomStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            continueButton.heightAnchor.constraint(equalToConstant: 44),
            continueButton.widthAnchor.constraint(equalToConstant: 193)
        ])
    }
    
}
