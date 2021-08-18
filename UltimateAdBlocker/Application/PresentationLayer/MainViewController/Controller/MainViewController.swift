//
//  MainViewController.swift
//  UltimateAdBlocker

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - Views
    private let blockersTableView = BlockersTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
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
            NSAttributedString.Key.font : Fonts.montserratSemiBold.of(size: 28)!,
            NSAttributedString.Key.foregroundColor : UIColor.instantinate(from: .mainYellow)
        ]
        
        self.navigationItem.title = "Super Blocker"
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        
    }

    
    
    //MARK: - SetupView
    private func setupView() {
        layoutView()
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
        view.addSubview(blockersTableView)
        
        blockersTableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(30)
            make.left.equalTo(view.snp.left).offset(20)
            make.right.equalTo(view.snp.right).offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-30)
        }
        
        blockersTableView.blockerDelegate = self
    }

}

extension MainViewController: BlockersTableViewDelegate {
    func didSelectBlocker() {
        premiumButtonTapped()
    }
}

