//
//  SettingsTableViewCell.swift
//  UltimateAdBlocker
//
//  Created by Pavel Buzdanov on 03.03.2021.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    //MARK: - Properties
    static let  identifier = "SettingsTableViewCell"
    
    
    public var data: SettingsModel? {
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
    
    private let container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12.0
        view.backgroundColor = UIColor.instantinate(from: .secondaryYellow)
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.montserratSemiBold.of(size: 20)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        return label
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
    }
    
    
    //MARK: - Configure Cell
    private func configureCell(with data: SettingsModel) {
        iconImageView.image = data.image
        titleLabel.text = data.description
    }
    
    
    
    //MARK: - Layout Cell
    private func layoutCell() {
        contentView.addSubview(container)
        container.addSubview(iconImageView)
        container.addSubview(titleLabel)
        
        
        iconImageView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 30, height: 30))
            make.centerY.equalTo(container.snp.centerY)
            make.left.equalTo(container.snp.left).offset(18)
            make.top.equalTo(container.snp.top).offset(24.0)
        }
        
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(iconImageView.snp.centerY)
            make.left.equalTo(iconImageView.snp.right).offset(18)
            make.right.equalTo(container.snp.right).offset(-10)
        }
        
        container.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView.snp.centerY)
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(contentView.snp.top).offset(15.0)
            make.leading.equalTo(contentView.snp.leading)
        }
        
    }
}
