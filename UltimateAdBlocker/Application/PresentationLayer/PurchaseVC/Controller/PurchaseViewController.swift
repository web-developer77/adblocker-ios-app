
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
        button.titleLabel?.font = Fonts.robotoRegular.of(size: 20)
        button.setTitleColor(#colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.231372549, alpha: 1), for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.addTarget(self, action: #selector(showWebView), for: .touchUpInside)
        return button
    }()
    
    private let showTermsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Terms Of Use", for: .normal)
        button.titleLabel?.font = Fonts.robotoRegular.of(size: 20)
        button.setTitleColor(#colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.231372549, alpha: 1), for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.addTarget(self, action: #selector(showWebView), for: .touchUpInside)
        return button
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "closeButton"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.adjustsImageWhenHighlighted = false
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.backgroundColor = .clear
        return button
    }()
    
    private let restoreButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Restore", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        button.titleLabel?.font = Fonts.robotoRegular.of(size: 20)
        button.addTarget(self, action: #selector(restoreButtonTapped), for: .touchUpInside)
        button.backgroundColor = .clear
        return button
    }()
    
    private let topImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "logo")
        return image
    }()
    
    private let descriptionImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "info1")
        return image
    }()
    
    private let backImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "backgroundPuschase")
        return image
    }()
    
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Subscription automatically renews"
        label.font = Fonts.robotoRegular.of(size: 18)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
 
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
        view.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.8588235294, blue: 0.1607843137, alpha: 1)
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
    
    private func presentMainView() {
        let vc = UINavigationController(rootViewController: MainViewController())
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
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
        view.addSubview(descriptionImageView)
        view.addSubview(closeButton)
        view.addSubview(restoreButton)
        view.addSubview(showPrivacyButton)
        view.addSubview(showTermsButton)
        view.addSubview(purchaseView)
        view.addSubview(descriptionLabel)
        
    
        
        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            
            restoreButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            restoreButton.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor),
            
            descriptionImageView.heightAnchor.constraint(equalToConstant: self.view.bounds.size.height * 0.4),
            descriptionImageView.widthAnchor.constraint(equalToConstant: self.view.bounds.size.width - 60),
            descriptionImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            
            showPrivacyButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            showPrivacyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            showTermsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            showTermsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            descriptionLabel.bottomAnchor.constraint(equalTo: showTermsButton.topAnchor, constant: -30),
            
            purchaseView.heightAnchor.constraint(equalToConstant: 80),
            purchaseView.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -5),
            purchaseView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            purchaseView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
           
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

