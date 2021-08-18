//
//  SettingsViewController.swift
//  UltimateAdBlocker
//
//  Created by Pavel Buzdanov on 03.03.2021.
//

import UIKit
import MessageUI


class SettingsViewController: UIViewController {
    
    //MARK: - Views
    private let settingTableView = SettingsTableView()

    private let childViewController = HelpViewController()
    
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupNavigationBar()
    }
    
    
    
    
    //MARK: - Setup Nav Bar
    private func setupNavigationBar() {
        
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font : Fonts.montserratSemiBold.of(size: 28.0)!,
            NSAttributedString.Key.foregroundColor : UIColor.instantinate(from: .mainYellow)
        ]
        
        self.navigationItem.title = "Settings"
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    
    
    //MARK: - SetupView
    private func setupView() {
        layoutView()
        view.backgroundColor = .black
        
        settingTableView.didSelectRow = { [weak self] (option) in
            switch option {
            case .ContactUs: self?.presentMail()
//            case .HelpWithSubsctiption: self?.showHelpViewController()
            case .Privacy: self?.presentWebVC(url: AppConstants.privacy)
            case .Terms: self?.presentWebVC(url: AppConstants.terms)
            }
            
        }
    }
    
    //MARK: - Private
    private func presentWebVC(url: String) {
        let vc = WebViewController()
        vc.urlString = url
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    
    private func presentMail() {
        if MFMailComposeViewController.canSendMail() {
            let mailVC = MFMailComposeViewController()
            mailVC.mailComposeDelegate = self
            mailVC.setSubject("Contact us! We will answer you within 10 days")
            mailVC.setToRecipients([AppConstants.email])
            mailVC.navigationBar.tintColor = .systemBlue
            mailVC.setEditing(true, animated: true)
            
            present(mailVC, animated: true) {
                mailVC.becomeFirstResponder()
            }
        } else {
            self.showAlertWithMassage("Error", "Sorry,but you can't send emails")
        }
    }
    
    
    private func showHelpViewController() {
        addChild(childViewController)
        childViewController.view.frame = view.frame
        view.isUserInteractionEnabled = true
        view.addSubview(childViewController.view)
        childViewController.didMove(toParent: self)
    }
    
    private func hideHelpViewController() {
        childViewController.willMove(toParent: nil)
        view.isUserInteractionEnabled = true
        childViewController.view.removeFromSuperview()
        childViewController.removeFromParent()
    }
    
    
    
    //MARK: - Layout View
    private func layoutView() {
        view.addSubview(settingTableView)

        settingTableView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(15)
            make.left.equalTo(view.snp.left).offset(30)
            make.right.equalTo(view.snp.right).offset(-30)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-30)        }
    }

  
}


//MARK: MFMailComposeViewControllerDelegate
extension SettingsViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
