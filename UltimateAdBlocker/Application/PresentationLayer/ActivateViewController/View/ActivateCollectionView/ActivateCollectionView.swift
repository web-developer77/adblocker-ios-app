//
//  ActivateCollectionView.swift
//  UltimateAdBlocker
//
//  Created by Pavel Buzdanov on 03.03.2021.
//

import UIKit

class ActivateCollectionView: UICollectionView {

  
    //MARK: - Properties
    private let data = ActivateModel.defaultModel
    
    var collectionViewWillDispalayClosure: ((IndexPath)->())?
    
    
    
    //MARK: - Constructor
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        super.init(frame: frame, collectionViewLayout: layout)
        
        translatesAutoresizingMaskIntoConstraints = false
        showsHorizontalScrollIndicator = false
        isPagingEnabled = true
        backgroundColor = .clear
        
        register(ActivateCollectionViewCell.self, forCellWithReuseIdentifier: ActivateCollectionViewCell.identifier)
        
        
        delegate = self
        dataSource = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//MARK: - UICollectionViewDelegate
extension ActivateCollectionView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.collectionViewWillDispalayClosure?(indexPath)
    }
    
}



extension ActivateCollectionView: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActivateCollectionViewCell.identifier, for: indexPath) as? ActivateCollectionViewCell else { fatalError("No UICollectionViewCell")  }
        
        let itemData = data[indexPath.item]
        
        cell.data = itemData
        
        
        return cell
    }
    
    
    
}
