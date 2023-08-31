//
//  OnboardingViewController.swift
//  RecipesApp
//
//  Created by Anna Zaitsava on 31.08.23.
//

import UIKit

class OnboardingViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var pages = [UIViewController]()
    let initialPage = 0
    lazy var pageControl: UIPageControl = {
        let pageControlView = UIPageControl()
        pageControlView.translatesAutoresizingMaskIntoConstraints = false
        pageControlView.frame = CGRect(x: 0, y: 0, width: 0, height: 80)
        pageControlView.currentPageIndicatorTintColor = .primary30
        pageControlView.pageIndicatorTintColor = .neutral20
        pageControlView.numberOfPages = self.pages.count
        pageControlView.currentPage = initialPage
        return pageControlView
    }()
    
    lazy var continueButton: UIButton = {
        var button = UIButton()
        
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = .poppinsRegular20()
        button.backgroundColor = .primary50
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 20
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.widthAnchor.constraint(equalToConstant: 193).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(handlerContinueButton), for: .touchUpInside)
        return button
    }()
    
    lazy var skipButton: UIButton = {
        var button = UIButton()
        
        button.setTitle("Skip", for: .normal)
        button.titleLabel?.font = .poppinsRegular10()
        button.setTitleColor(.white, for: .normal)
        
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
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
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
        let vc = HomeViewController()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        
        show(vc, sender: self)
        
    }
    
    @objc func handleSkipButton() {
        let vc = HomeViewController()
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
        
        
        let page1 = PagesViewController(imageName: "Onboarding Page-1", titleText: "Recipes from all over the World", subtitleText: "")
        let page2 = PagesViewController(imageName: "Onboarding Page-2", titleText: "Recipes with each and every detail", subtitleText: "")
        let page3 = PagesViewController(imageName: "Onboarding Page-3", titleText: "Cook it now or save it for later", subtitleText: "")
        
        
        self.pages.append(page1)
        self.pages.append(page2)
        self.pages.append(page3)
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
        
        
        
        view.addSubview(bottomStack)
        bottomStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bottomStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        
       
        
    }
    
}

