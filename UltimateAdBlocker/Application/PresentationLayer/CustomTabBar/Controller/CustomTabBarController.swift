//
//  CustomTabBarController.swift
//  UltimateAdBlocker
//
//  Created by Pavel Buzdanov on 02.03.2021.
//

import UIKit
import SafariServices

class CustomTabBarController: UITabBarController {
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        
        [AppConstants.adsBlockerBundle, AppConstants.pornBlokerBundle, AppConstants.malwareBlockerBundle, AppConstants.trackBlockerBundle].forEach( { SFContentBlockerManager.reloadContentBlocker(withIdentifier: $0, completionHandler: nil) } )
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    
    //MARK: - Setup Tab Bar
    private func setupTabBar() {
        self.tabBar.tintColor = #colorLiteral(red: 0.9960784314, green: 0.8588235294, blue: 0.1607843137, alpha: 1)
        self.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.8745098039, green: 0.8862745098, blue: 0.9215686275, alpha: 1)
        self.viewControllers = [createFirstVC(),  createSecondVC(), createThirdVC()]
        
        self.tabBar.isTranslucent = true
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.shadowImage = UIImage()
        self.tabBar.clipsToBounds = true
        
        if DeviceType.iPhone8 || DeviceType.iPhoneSE {
            self.tabBar.backgroundColor = #colorLiteral(red: 0.1254901961, green: 0.1137254902, blue: 0.1803921569, alpha: 1)
            self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            self.tabBar.layer.cornerRadius = 30
            
        } else {
            let layer = CAShapeLayer()
            layer.path = UIBezierPath(roundedRect: CGRect(x: 30, y: self.tabBar.bounds.minY + 5, width: self.tabBar.bounds.width - 60, height: self.tabBar.bounds.height + 10), cornerRadius: (self.tabBar.frame.width/2)).cgPath
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = .zero
            layer.shadowRadius = 2
            layer.shadowOpacity = 0.3
            layer.borderWidth = 1.0
            layer.opacity = 1.0
            layer.isHidden = false
            layer.masksToBounds = false
            layer.fillColor = #colorLiteral(red: 0.1254901961, green: 0.1137254902, blue: 0.1803921569, alpha: 1)
            self.tabBar.layer.insertSublayer(layer, at: 0)
            
            if let items = self.tabBar.items {
                items.forEach { item in item.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -15, right: 0) }
            }
            
            self.tabBar.itemWidth = 30.0
            self.tabBar.itemPositioning = .automatic
        }

    }
    
    
    
}

//MARK: - Configure
extension CustomTabBarController {
    
    private func createFirstVC() -> UIViewController {
        let vc = UINavigationController(rootViewController: MainViewController())
        let image = UIImage(named: "home")
        vc.tabBarItem = UITabBarItem(title: "", image: image, tag: 0)
        return vc
    }
    
    private func createSecondVC() -> UIViewController {
        let vc =  UINavigationController(rootViewController: ActivateViewController())
        let image = UIImage(named: "info")
        vc.tabBarItem = UITabBarItem(title: "", image: image, tag: 1)
        return vc
    }
    private func createThirdVC() -> UIViewController {
        let vc =  UINavigationController(rootViewController: SettingsViewController())
        let image = UIImage(named: "settings")
        vc.tabBarItem = UITabBarItem(title: "", image: image, tag: 2)
        return vc
    }
}
