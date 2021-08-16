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
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.robotoBold.of(size: 18)
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
        
        iconImageView.layer.cornerRadius = 12
        iconImageView.clipsToBounds = true
    }
    
    
    //MARK: - Configure Cell
    private func configureCell(with data: SettingsModel) {
        iconImageView.image = data.image
        titleLabel.text = data.description
    }
    
    
    
    //MARK: - Layout Cell
    private func layoutCell() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        
        
        iconImageView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 60, height: 72))
            make.centerY.equalTo(contentView.snp.centerY)
            make.left.equalTo(contentView.snp.left).offset(18)
        }
        
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(iconImageView.snp.centerY)
            make.left.equalTo(iconImageView.snp.right).offset(18)
            make.right.equalTo(contentView.snp.right).offset(-10)
        }
        
    }
}
