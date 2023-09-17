import UIKit

class OnboardingViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var pages = [UIViewController]()
    let initialPage = 0
    lazy var pageControl: UIPageControl = {
        let pageControlView = UIPageControl()
        pageControlView.translatesAutoresizingMaskIntoConstraints = false
//        pageControlView.frame = CGRect(x: 0, y: 0, width: 140, height: 8)
        pageControlView.widthAnchor.constraint(equalToConstant: 220).isActive = true
        pageControlView.numberOfPages = self.pages.count
        pageControlView.currentPage = initialPage
        pageControlView.preferredIndicatorImage = UIImage(named: "default")
        pageControlView.currentPageIndicatorTintColor = .primary30
        pageControlView.pageIndicatorTintColor = .neutral20
        
      
        return pageControlView
    }()
    
    lazy var continueButton: UIButton = {
        let button = UIButton(name: "Continue", backgroundColor: .primary50, font: .poppinsRegular20(), titleColor: .white)
        button.clipsToBounds = true
        button.layer.cornerRadius = 20
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.widthAnchor.constraint(equalToConstant: 193).isActive = true
        
        button.addTarget(self, action: #selector(handlerContinueButton), for: .touchUpInside)
        return button
    }()
    
    lazy var skipButton: UIButton = {
        let button = UIButton(name: "Skip", backgroundColor: .clear, font: .poppinsRegular10(), titleColor: .white)
        button.addTarget(self, action: #selector(handleSkipButton), for: .touchUpInside)
        return button
    }()
    
    lazy var bottomStack: UIStackView = {
        let buttonsStackView = UIStackView(arrangedSubviews: [continueButton,skipButton])
        buttonsStackView.axis = .vertical
        buttonsStackView.spacing = 12
        
        let bottomStackView = UIStackView(arrangedSubviews: [pageControl, buttonsStackView])
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.axis = .vertical
        bottomStackView.spacing = 31
        bottomStackView.distribution = .equalCentering
        bottomStackView.sizeToFit()
        bottomStackView.layoutIfNeeded()
        
        return bottomStackView
    }()
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle,
                  navigationOrientation: UIPageViewController.NavigationOrientation,
                  options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handlerContinueButton() {
        if continueButton.currentTitle == "Continue" {
            print ("handleContinueButton")
            continueAction()
            
        } else {
            print ("startCookingButton")
            startAction()
        }
    }
    
    func continueAction() {
        if pageControl.currentPage == pages.count - 2{
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
        
        let page1 = PagesViewController(imageName:  "Onboarding Page-1", titleTextFirstPart: "Recipes from all ", titleTextSecondPart: "over the World", subtitleText: "")
        let page2 = PagesViewController(imageName: "Onboarding Page-2", titleTextFirstPart: "Recipes with ", titleTextSecondPart: "each and every detail", subtitleText: "")
        let page3 = PagesViewController(imageName: "Onboarding Page-3", titleTextFirstPart: "Cook it now or ", titleTextSecondPart: "save it for later", subtitleText: "")
        
        
        self.pages.append(page1)
        self.pages.append(page2)
        self.pages.append(page3)
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
        
        
        
        view.addSubview(bottomStack)
        bottomStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bottomStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    }
}
