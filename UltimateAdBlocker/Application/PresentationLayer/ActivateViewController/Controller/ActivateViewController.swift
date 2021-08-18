//
//  ActivateViewController.swift
//  UltimateAdBlocker
//
//  Created by Pavel Buzdanov on 03.03.2021.
//

import UIKit
import KeychainSwift

class ActivateViewController: UIViewController {
    
    //MARK: - Properties
    private var counter = 0
    
    //MARK: - Views
    private let nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.adjustsImageWhenHighlighted = false
        button.layer.cornerRadius = 12.0
        button.backgroundColor = UIColor.instantinate(from: .mainYellow)
        button.setTitle("Continue", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = Fonts.montserratSemiBold.of(size: 20.0)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let pageControll: UIPageControl = {
        let pageControll = UIPageControl()
        pageControll.translatesAutoresizingMaskIntoConstraints = false
        pageControll.currentPage = 0
        pageControll.numberOfPages = ActivateModel.defaultModel.count
        pageControll.pageIndicatorTintColor = UIColor.instantinate(from: .inActiveIndicator)
        pageControll.currentPageIndicatorTintColor = UIColor.instantinate(from: .mainYellow)
        return pageControll
    }()
    
    private let titleLB: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontSizeToFitWidth = true
        label.font = Fonts.montserratSemiBold.of(size: 28.0)
        label.textAlignment = .center
        label.textColor = UIColor.instantinate(from: .mainYellow)
        label.text = "To get started, \nallow Ad Blocker"
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(gestureTapped)))
        return label
    }()
    
    private let activeteCollectionView = ActivateCollectionView()

    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(gestureTapped))
        self.navigationController?.navigationBar.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
    //MARK: - SetupView
    private func setupView() {
        layoutView()
        setupNavigationBar()
        view.backgroundColor = .black
        
        activeteCollectionView.collectionViewWillDispalayClosure = { [weak self] (index) in
            self?.pageControll.currentPage = index.item

            if index.item == ActivateModel.defaultModel.count - 1 {
                self?.nextButton.removeTarget(nil, action: nil, for: .allEvents)
                self?.nextButton.addTarget(self, action: #selector(self?.openSettings), for: .touchUpInside)
            } else {
                self?.nextButton.removeTarget(nil, action: nil, for: .allEvents)
                self?.nextButton.addTarget(self, action: #selector(self?.nextButtonTapped), for: .touchUpInside)
            }
        }
    }
    
    
    //MARK: - Setup Nav Bar
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.isHidden = true
        
        
    }
    
    //MARK: - Private
    @objc private func nextButtonTapped() {
        guard let currentPage = activeteCollectionView.indexPathsForVisibleItems.first else { return }
        
        let nextIndexPath = IndexPath(item: currentPage.row + 1, section: currentPage.section)
        
        activeteCollectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc private func openSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }

            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                  print("")
                })
            }
    }
    
    @objc private func gestureTapped() {
        counter += 1
        
        if counter == 10 {
            print("refresh")
            let keychain = KeychainSwift()
            
            keychain.set(false, forKey: "cl")
            keychain.set("", forKey: "date1")
            keychain.set("", forKey: "dt")
            counter = 0
        }
    }

    
    //MARK: - LayoutView
    private func layoutView() {
        view.addSubview(activeteCollectionView)
        view.addSubview(nextButton)
        view.addSubview(pageControll)
        view.addSubview(titleLB)
        
        nextButton.snp.makeConstraints { (make) in
            make.height.equalTo(57)
            make.width.equalTo(view.bounds.size.width - 60)
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-30)
        }
        
        pageControll.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(nextButton.snp.top).offset(-30)
        }
        
        titleLB.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.snp.top).offset(ScreenSize.screenHeight > 736 ? 54.0 : 10.0)
        }
        
        activeteCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLB.snp.bottom).offset(15)
            make.bottom.equalTo(pageControll.snp.top).offset(-15)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
        }
    }
    

}
