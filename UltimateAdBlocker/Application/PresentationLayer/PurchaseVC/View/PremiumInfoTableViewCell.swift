//
//  PremiumTableViewCell.swift
//  UltimateAdBlocker
//
//  Created by Aira on 17.08.2021.
//

import UIKit

class PremiumInfoTableViewCell: UITableViewCell {

    //MARK: - Properties
    static let  identifier = "PremiumInfoTableViewCell"
    
    
    public var data: PremiumInfoModel? {
        didSet {
            if let data = data {
                self.configureCell(with: data)
            }
        }
    }
    
    //MARK: - Views
    private let iconImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.instantinate(from: .mainTabBar)
        view.layer.cornerRadius = 16.0
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.montserratSemiBold.of(size: 18)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.montserratRegular.of(size: 14)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        return label
    }()
    
    
    private let trailingImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = UIImage.instantinate(from: .premiumTrail)
        return image
    }()
    
    
    
    //MARK: - Constructor
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    //MARK: - Setup Cell
    private func setupCell() {
        layoutCell()
        
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        iconImageView.layer.cornerRadius = 12
        iconImageView.clipsToBounds = true
    }
    
    
    //MARK: - Configure Cell
    private func configureCell(with data: PremiumInfoModel) {
        iconImageView.image = data.image
        titleLabel.text = data.title
        subTitleLabel.text = data.description
    }
    
    
    
    //MARK: - Layout Cell
    private func layoutCell() {
        container.addSubview(iconImageView)
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subTitleLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 6
        
        
        container.addSubview(trailingImageView)
        container.addSubview(stackView)
        
        iconImageView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.centerY.equalTo(container.snp.centerY)
            make.left.equalTo(container.snp.left).offset(18)
        }
        
        trailingImageView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 30, height: 30))
            make.centerY.equalTo(container.snp.centerY)
            make.right.equalTo(container.snp.right).offset(-18)
        }
        stackView.snp.makeConstraints { (make) in
            make.centerY.equalTo(iconImageView.snp.centerY)
            make.left.equalTo(iconImageView.snp.right).offset(18)
            make.right.equalTo(trailingImageView.snp.left).offset(-10)
        }
        
        
        contentView.addSubview(container)
        container.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(14.0)
            make.bottom.equalTo(contentView.snp.bottom).offset(-14.0)
            make.left.equalTo(contentView.snp.left).offset(0.0)
            make.right.equalTo(contentView.snp.right).offset(0.0)
        }
    }
}
