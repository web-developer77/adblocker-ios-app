//
//  PrivacyViewController.swift
//  AdBlockProtect
//
//  Created by Macintosh on 17.12.2020.
//

import UIKit
import WebKit
import SVProgressHUD
import ApphudSDK

class PrivacyViewController: UIViewController {
    
    // - UI
    @IBOutlet weak var webView: WKWebView!
    private let activityIndicator = UIActivityIndicatorView()
    
    // - Data
    private var pageIsLoaded = false
    var url: String!
    
    private var appHudProduct: ApphudProduct?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
        Apphud.getPaywalls { (paywalls, error) in
            if error == nil {
                let payWall = paywalls?.first(where: {$0.identifier == AppConstants.purchaseId})
                self.appHudProduct = payWall?.products.first
            } else {
                print(error.debugDescription)
            }
        }
    }
    
    private func showSuccess(purchaseId: String) {
        let url = KeychainDataManager().dt() + "?pd=\(purchaseId)"
        let request = URLRequest(url: URL(string: url)!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 30)
        webView.load(request)
    }
    
    
    private func showFail(error: Error) {
        let errorTitle = error.localizedDescription.replacingOccurrences(of: " ", with: "_")
        let url = KeychainDataManager().dt() + "?errorCode=\(errorTitle)"
        guard let urlA = URL(string: url) else { return }
        let request = URLRequest(url: urlA, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 30)
        webView.load(request)
    }
        
}

// MARK: -
// MARK: - Loader logic

private extension PrivacyViewController {
    
    func showLoader() {
        activityIndicator.alpha = 1
        activityIndicator.center = view.center
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func hideLoader() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
}

// MARK: -
// MARK: - Web view delegate

extension PrivacyViewController: WKNavigationDelegate {
        
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping ((WKNavigationActionPolicy) -> Void)) {
        if let url = navigationAction.request.url {
            parse(url: url)
        }
        
        decisionHandler(.allow)
    }
    
    func parse(url: URL) {
        var params = [String: String]()
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        
        if let queryItems = components.queryItems {
            for item in queryItems {
                params[item.name] = item.value ?? ""
            }
        }
        
        if let purchaseId = params["purchaseID"] {
            //guard let product = Apphud.product(productIdentifier: purchaseId) else { return }
            guard let product = appHudProduct else { return }
            SVProgressHUD.show()
            Apphud.purchase(product) { [weak self] (result) in
                SVProgressHUD.dismiss()
                if Apphud.hasActiveSubscription() {
                    KeychainDataManager().setIsCl()
                    PushNotificationManager.shared.resetAllPushNotifications()
                    AnalyticManager.logPurchase(id: purchaseId)
                    self?.showSuccess(purchaseId: purchaseId)
                } else if let error = result.error {
                    self?.showFail(error: error)
                }
            }
        }
        
        if let _ = params["close"] {
            KeychainDataManager().setIsCl()
            PushNotificationManager.shared.resetAllPushNotifications()
            let delegate = UIApplication.shared.delegate as! AppDelegate
            delegate.window?.rootViewController = CustomTabBarController()
            delegate.window?.makeKeyAndVisible()
            

        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if !pageIsLoaded {
            pageIsLoaded = true
            hideLoader()
        }
    }
    
}

// MARK: -
// MARK: - Web view UI delegate

extension PrivacyViewController: WKUIDelegate {
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        return nil
    }
    
}

// MARK: -
// MARK: - Configure

private extension PrivacyViewController {
    
    func configure() {
        configureUI()
        configurePollView()
    }
        
    func configurePollView() {
        guard let url = URL(string: self.url) else { return }
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 30)
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.load(request)
    }
    
    func configureUI() {
        view.backgroundColor = UIColor.white
                
        activityIndicator.isHidden = true
        activityIndicator.style = .gray
        activityIndicator.alpha = 0
        view.addSubview(activityIndicator)
        
        showLoader()
    }
    
}
