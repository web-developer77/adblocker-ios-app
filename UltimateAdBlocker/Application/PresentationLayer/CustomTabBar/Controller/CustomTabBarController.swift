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
        self.tabBar.tintColor = UIColor.instantinate(from: .mainYellow)
        self.tabBar.unselectedItemTintColor = .white
        self.viewControllers = [createFirstVC(),  createSecondVC(), createThirdVC()]
        
        self.tabBar.isTranslucent = true
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.shadowImage = UIImage()
        self.tabBar.clipsToBounds = true
        
        self.tabBar.layer.backgroundColor = UIColor.instantinate(from: .mainTabBar).cgColor
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.tabBar.layer.cornerRadius = 30
    }
    
    
    
}

//MARK: - Configure
extension CustomTabBarController {
    
    private func createFirstVC() -> UIViewController {
        let vc = UINavigationController(rootViewController: MainViewController())
        vc.tabBarItem = UITabBarItem(title: "General", image: UIImage.instantinate(from: .unselectedTabGeneral), selectedImage: UIImage.instantinate(from: .selectedTabGeneral))
        return vc
    }
    
    private func createSecondVC() -> UIViewController {
        let vc =  UINavigationController(rootViewController: ActivateViewController())
        vc.tabBarItem = UITabBarItem(title: "How to install", image: UIImage.instantinate(from: .unselectedTabGuide), selectedImage: UIImage.instantinate(from: .selectedTabGuide))
        return vc
    }
    private func createThirdVC() -> UIViewController {
        let vc =  UINavigationController(rootViewController: SettingsViewController())
        vc.tabBarItem = UITabBarItem(title: "Settings", image: UIImage.instantinate(from: .unselectedTabSetting), selectedImage: UIImage.instantinate(from: .selectedTabSetting))
        return vc
    }
}
