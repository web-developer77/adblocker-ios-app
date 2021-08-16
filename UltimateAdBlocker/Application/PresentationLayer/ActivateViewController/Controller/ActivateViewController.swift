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
        button.imageView?.contentMode = .scaleAspectFill
        button.setImage(UIImage(named: "nextImage"), for: .normal)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let pageControll: UIPageControl = {
       let pageControll = UIPageControl()
        pageControll.translatesAutoresizingMaskIntoConstraints = false
        pageControll.currentPage = 0
        pageControll.numberOfPages = ActivateModel.defaultModel.count
        pageControll.pageIndicatorTintColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        pageControll.currentPageIndicatorTintColor = #colorLiteral(red: 0.9960784314, green: 0.8588235294, blue: 0.1607843137, alpha: 1)
        return pageControll
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
        
        nextButton.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        nextButton.layer.shadowOffset = .zero
        nextButton.layer.shadowOpacity = 0.5
        nextButton.layer.shadowRadius = 8
        
        
        
    }
    
    
    //MARK: - SetupView
    private func setupView() {
        layoutView()
        setupNavigationBar()
        view.backgroundColor = #colorLiteral(red: 0.8745098039, green: 0.8862745098, blue: 0.9215686275, alpha: 1)
        
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
        
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font : Fonts.comfortaaBold.of(size: 25)!,
            NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ]
        
        self.navigationItem.title = "Ultimate Blocker"
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        
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
        
        nextButton.snp.makeConstraints { (make) in
            make.height.equalTo(90)
            make.width.equalTo(view.bounds.size.width - 60)
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-30)
        }
        
        pageControll.snp.makeConstraints { (make) in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(nextButton.snp.top).offset(-10)
        }
        
        activeteCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(15)
            make.bottom.equalTo(pageControll.snp.top).offset(-15)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
        }
    }
    

}
