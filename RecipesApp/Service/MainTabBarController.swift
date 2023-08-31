//
//  MainTabBarController.swift
//  RecipesApp
//
//  Created by Владислав on 27.08.2023.
//

import UIKit

class MainTabBarController : UITabBarController {
    let btnMiddle : UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        btn.setTitle("", for: .normal)
        btn.layer.cornerRadius = 30
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.2
        btn.layer.shadowOffset = CGSize(width: 4, height: 4)
        btn.setBackgroundImage(UIImage(named: "plus"), for: .normal)
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSomeTabItems()
        btnMiddle.frame = CGRect(x: Int(self.tabBar.bounds.width)/2 - 30, y: -32, width: 60, height: 60)
    }
    override func loadView() {
        super.loadView()
        self.tabBar.addSubview(btnMiddle)
        setupCustomTabBar()
    }
    
    func setupCustomTabBar() {
        
        let path : UIBezierPath = getPathForTabBar()
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.lineWidth = 1
        shape.strokeColor = UIColor.neutral40.cgColor
        shape.fillColor = UIColor.neutral0.cgColor
        self.tabBar.layer.insertSublayer(shape, at: 0)
        self.tabBar.itemWidth = 40
        self.tabBar.layer.insertSublayer(shape, at: 0)
        self.tabBar.unselectedItemTintColor = .neutral50
        self.tabBar.tintColor = .primary50
    }
    
    func addSomeTabItems() {
        let home = HomeViewController()
        let discover = DiscoverViewController()
        let notification = UIViewController()
        let profile = SeeAllViewController()
        
        setViewControllers([home, discover, notification, profile], animated: true)
        
        guard let items = tabBar.items else { return }
        
        items[0].image = UIImage(named: "home")
        items[1].image = UIImage(named: "inactive")
        items[2].image = UIImage(named: "notification")
        items[3].image = UIImage(named: "profile")
        items[0].imageInsets = UIEdgeInsets(top: 15, left: -5, bottom: -15, right: 0)
        items[1].imageInsets = UIEdgeInsets(top: 15, left: -55, bottom: -15, right: 0)
        items[2].imageInsets = UIEdgeInsets(top: 15, left: 0, bottom: -15, right: -55)
        items[3].imageInsets = UIEdgeInsets(top: 15, left: 0, bottom: -15, right: -5)
    }
    
    func getPathForTabBar() -> UIBezierPath {
        let frameWidth = self.tabBar.bounds.width
        let frameHeight = UIScreen.main.bounds.height - self.view.safeAreaInsets.bottom
        let holeWidth = 145
        let holeHeight = 34
        let leftXUntilHole = Int(frameWidth/2) - Int(holeWidth/2)
        
        let path : UIBezierPath = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: leftXUntilHole , y: 0)) // 1.Line
        path.addCurve(to: CGPoint(x: leftXUntilHole + (holeWidth/3), y: holeHeight/2), controlPoint1: CGPoint(x: leftXUntilHole + ((holeWidth/3)/8)*6,y: 0), controlPoint2: CGPoint(x: leftXUntilHole + ((holeWidth/3)/8)*8, y: holeHeight/2)) // part I
        
        path.addCurve(to: CGPoint(x: leftXUntilHole + (2*holeWidth)/3, y: holeHeight/2), controlPoint1: CGPoint(x: leftXUntilHole + (holeWidth/3) + (holeWidth/3)/3*2/5, y: (holeHeight/2)*6/4), controlPoint2: CGPoint(x: leftXUntilHole + (holeWidth/3) + (holeWidth/3)/3*2 + (holeWidth/3)/3*3/5, y: (holeHeight/2)*6/4)) // part II
        
        path.addCurve(to: CGPoint(x: leftXUntilHole + holeWidth, y: 0), controlPoint1: CGPoint(x: leftXUntilHole + (2*holeWidth)/3,y: holeHeight/2), controlPoint2: CGPoint(x: leftXUntilHole + (2*holeWidth)/3 + (holeWidth/3)*2/8, y: 0)) // part III
        path.addLine(to: CGPoint(x: frameWidth, y: 0)) // 2. Line
        path.addLine(to: CGPoint(x: frameWidth, y: frameHeight)) // 3. Line
        path.addLine(to: CGPoint(x: 0, y: frameHeight)) // 4. Line
        path.addLine(to: CGPoint(x: 0, y: 0)) // 5. Line
        path.close()
        return path
    }
}
