//
//  MainViewController.swift
//  UltimateAdBlocker

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - Views
    private let blockersTableView = BlockersTableView()

    private let premiumButton: UIButton = {
      let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.adjustsImageWhenHighlighted = false
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.8745098039, green: 0.8862745098, blue: 0.9215686275, alpha: 1)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        blockersTableView.reloadData()
        setupView()
        setupNavigationBar()
    }
    
    
    //MARK: - Setup Nav Bar
    private func setupNavigationBar() {
        
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font : Fonts.comfortaaBold.of(size: 25)!,
            NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ]
        
        self.navigationItem.title = "Ultimate Blocker"
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        
    }

    
    
    //MARK: - SetupView
    private func setupView() {
        layoutView()
        
        if hasActiveSubscription {
            premiumButton.setImage(UIImage(named: "premiumActivated"), for: .normal)
            premiumButton.removeTarget(self, action: nil, for: .allEvents)
        } else {
            premiumButton.addTarget(self, action: #selector(premiumButtonTapped), for: .touchUpInside)
            premiumButton.setImage(UIImage(named: "premiumButton"), for: .normal)
        }
    }
    
    
    //MARK: - Privete
    @objc private func premiumButtonTapped() {
        let vc = PurchaseViewController()
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    //MARK: - Layout View
    private func layoutView() {
        view.addSubview(premiumButton)
        view.addSubview(blockersTableView)
        
        premiumButton.snp.makeConstraints { (make) in
            make.height.equalTo(90)
            make.left.equalTo(view.snp.left).offset(30)
            make.right.equalTo(view.snp.right).offset(-30)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
        }
       
        
        blockersTableView.snp.makeConstraints { (make) in
            make.top.equalTo(premiumButton.snp.bottom).offset(30)
            make.left.equalTo(view.snp.left).offset(30)
            make.right.equalTo(view.snp.right).offset(-30)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-30)
        }
    }
    
    

}

