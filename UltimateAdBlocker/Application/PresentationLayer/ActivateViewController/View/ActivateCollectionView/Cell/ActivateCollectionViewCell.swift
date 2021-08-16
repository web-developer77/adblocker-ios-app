//
//  ActivateCollectionViewCell.swift
//  UltimateAdBlocker
//
//  Created by Pavel Buzdanov on 03.03.2021.
//

import UIKit

class ActivateCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    static let identifier = "ActivateCollectionViewCell"
    
    var data: ActivateModel? {
        didSet {
            if let data = data {
                self.configureCell(with: data)
            }
        }
    }
    
    
    //MARK: - Views
    private let topDescriptionLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.text = "To get started, \nallow Ad Blocker"
        label.numberOfLines = 2
        label.textAlignment = .center
        if DeviceType.iPhone8 || DeviceType.iPhoneSE {
            label.font = Fonts.comfortaaBold.of(size: 20)
        } else {
            label.font = Fonts.comfortaaBold.of(size: 25)
        }
      
        return label
    }()
    
    private let imageView: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let buttomDescriptionLabel: UILabel = {
      let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.robotoBold.of(size: 20)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        return label
    }()
    
    //MARK: - Constructor
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Layout Subvies
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        imageView.layer.shadowOffset = .zero
        imageView.layer.shadowOpacity = 0.3
        imageView.layer.shadowRadius = 8
    }
    
    
    
    //MARK: - Setup Cell
    private func setupCell(){
        layoutCell()
        backgroundColor = .clear
        
        
    }
    
    //MARK: - Configure Cell
    private func configureCell(with data: ActivateModel) {
        imageView.image = UIImage(named: data.imageName)
        buttomDescriptionLabel.text = data.text
    }
    
    
    
    //MARK: - Layout Cell
    private func layoutCell() {
        contentView.addSubview(topDescriptionLabel)
        contentView.addSubview(imageView)
        contentView.addSubview(buttomDescriptionLabel)
        
        imageView.snp.makeConstraints { (make) in
            make.center.equalTo(contentView.snp.center)
            let size =  contentView.bounds.size.width * 0.5
            make.size.equalTo(CGSize(width: size, height: size))
        }
        
        topDescriptionLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView.snp.centerX)
            make.bottom.equalTo(imageView.snp.top).offset(-30)
        }
        
        buttomDescriptionLabel.snp.makeConstraints { (make) in
            make.width.equalTo(contentView.bounds.size.width - 60)
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(imageView.snp.bottom).offset(30)
        }
        
        
    }

}
