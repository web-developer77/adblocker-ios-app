
import UIKit
import StoreKit
import ApphudSDK

class PurchaseViewController: UIViewController {
    
    //MARK: - Properties
    private let childViewController = LoadingCircleViewController()

    //MARK: - Views
    private let showPrivacyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Privacy Policy", for: .normal)
        button.titleLabel?.font = Fonts.montserratRegular.of(size: 14)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.addTarget(self, action: #selector(showWebView), for: .touchUpInside)
        return button
    }()
    
    private let showTermsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Terms Of Use", for: .normal)
        button.titleLabel?.font = Fonts.montserratRegular.of(size: 14)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.addTarget(self, action: #selector(showWebView), for: .touchUpInside)
        return button
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = Fonts.montserratSemiBold.of(size: 20)
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.backgroundColor = .clear
        return button
    }()
    
    private let restoreButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Restore", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = Fonts.montserratSemiBold.of(size: 20)
        button.addTarget(self, action: #selector(restoreButtonTapped), for: .touchUpInside)
        button.backgroundColor = .clear
        return button
    }()
    
    let titleLB: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Premium Features"
        label.font = Fonts.montserratSemiBold.of(size: 28)
        label.textColor = UIColor.instantinate(from: .mainYellow)
        label.textAlignment = .center
        return label
    }()
    
//    let tableView: UITableView = {
//        let view = UITableView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .clear
//        view.isScrollEnabled = false
//        view.separatorStyle = .none
//        view.register(PremiumInfoTableViewCell.self, forCellReuseIdentifier: PremiumInfoTableViewCell.identifier)
//        view.allowsMultipleSelection = false
//        view.allowsSelection = false
//        return view
//    }()
    
    private let tableView = PremiumTabelView()
    
    private let purchaseView = PurchaseView()
    
    private var appHudProduct: ApphudProduct?
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        Apphud.getPaywalls { (paywalls, error) in
            if error == nil {
                let payWall = paywalls?.first(where: {$0.identifier == AppConstants.purchaseId})
                self.appHudProduct = payWall?.products.first
            } else {
                print(error.debugDescription)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configurePurchaseView()
    }
    
    //MARK: - Setup View
    private func setupView() {
        view.backgroundColor = .black
        layout()
        
    }

    //MARK: - Private Functions
    @objc private func closeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func showWebView(_ sender: UIButton) {
        if sender == showPrivacyButton {
            presentWebView(link: AppConstants.privacy)
        } else {
            presentWebView(link: AppConstants.terms)
        }
    }
    
    private func presentWebView(link: String) {
        let vc = WebViewController()
        vc.urlString = link
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    //MARK: - Loading View Controller
    private func showLoadingViewController() {
        addChild(childViewController)
        childViewController.view.frame = view.frame
        view.isUserInteractionEnabled = false
        view.addSubview(childViewController.view)
        childViewController.didMove(toParent: self)
    }
    
    private func hideLoadingViewController() {
        childViewController.willMove(toParent: nil)
        view.isUserInteractionEnabled = true
        childViewController.view.removeFromSuperview()
        childViewController.removeFromParent()
    }
    
    //MARK: - Configure Purchase View
    private func configurePurchaseView() {
        Apphud.refreshStoreKitProducts { (_) in }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(purchaseViewTapped))
        
        if hasActiveSubscription {
            purchaseView.removeGestureRecognizer(tapGestureRecognizer)
            purchaseView.priceLabel.text = "You already have subscription"
            restoreButton.isHidden = true
            purchaseView.hideIndicator()
        } else {
            purchaseView.addGestureRecognizer(tapGestureRecognizer)
            
            restoreButton.isHidden = false
            if let product = Apphud.product(productIdentifier: AppConstants.purchaseId) {
                configurePriceLabel(with: product)
                
            } else {
                Apphud.refreshStoreKitProducts { [weak self] (_) in
                    guard let self = self else { return }
                    if let product = Apphud.product(productIdentifier: AppConstants.purchaseId) {
                        self.configurePriceLabel(with: product)
                    }
                }
            }
        }
    }
    
    private func configurePriceLabel(with product: SKProduct) {
        
        let introductoryNumberOfUnits = product.introductoryPrice?.subscriptionPeriod.numberOfUnits ?? 0
        
        var descriptionText = ""
        if introductoryNumberOfUnits == 0 {
            descriptionText = "\(product.myLocalizedPrice) / \(product.durationPeriod.lowercased())"
        } else {
            descriptionText = "\(introductoryNumberOfUnits)-\(product.introductoryPeriod) trial, then \(product.myLocalizedPrice) \(product.durationPeriod.lowercased())"
        }
        
        purchaseView.priceLabel.text = descriptionText
        purchaseView.hideIndicator()
    }
    
    //MARK: - Layout
    private func layout() {
        view.addSubview(closeButton)
        view.addSubview(restoreButton)
        view.addSubview(showPrivacyButton)
        view.addSubview(showTermsButton)
        view.addSubview(purchaseView)
        view.addSubview(titleLB)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            
            restoreButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            restoreButton.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor),
            
            titleLB.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 30),
            titleLB.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            showPrivacyButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            showPrivacyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            showTermsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            showTermsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            purchaseView.heightAnchor.constraint(equalToConstant: 57),
            purchaseView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            purchaseView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            purchaseView.bottomAnchor.constraint(equalTo: showPrivacyButton.topAnchor, constant: -60),
            
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.topAnchor.constraint(equalTo: titleLB.bottomAnchor, constant: 25),
            tableView.bottomAnchor.constraint(equalTo: purchaseView.topAnchor, constant: -40),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15)
        ])
    }
}

//MARK: - Extensions
extension PurchaseViewController {
    
    //MARK: - Restore
    @objc private func restoreButtonTapped() {

        showLoadingViewController()

        Apphud.restorePurchases { [weak self] (subs, purchases, error) in
            guard let self = self else { return }
            if hasActiveSubscription {
                self.showAlertWithMassage("Great", "Now you are safe!")
                self.hideLoadingViewController()
                self.dismiss(animated: true, completion: nil)

            } else {
                self.showAlertWithMassage("Error", "Nothing to restore")
                self.hideLoadingViewController()
            }
        }
    }

    //MARK: - Purchase
    @objc private func purchaseViewTapped() {
        showLoadingViewController()
        //guard let product = Apphud.product(productIdentifier: AppConstants.purchaseId) else { return }
        guard let product = appHudProduct else { return }
        Apphud.purchase(product) { [weak self] (result) in
            guard let self = self else { return }

            if Apphud.hasActiveSubscription() {
                self.showAlertWithMassage("Great", "Now you are safe!")
                self.hideLoadingViewController()
                self.dismiss(animated: true, completion: nil)
            } else {
                self.hideLoadingViewController()
                self.showAlertWithMassage("Error", "Please try a bit later")
            }
        }
    }
    
}




