//
//  BlockerTableViewCell.swift
//  UltimateAdBlocker
//
//  Created by Pavel Buzdanov on 02.03.2021.
//

import UIKit
import LabelSwitch
import SafariServices

class BlockerTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    static let  identifier = "BlockerTableViewCell"
    
    
    public var data: BlockerModel? {
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
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.robotoLight.of(size: 18)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        return label
    }()
    
    
    private lazy var swither: LabelSwitch = {
        let ls = LabelSwitchConfig(text: "ON",
                                   textColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
                                   font: UIFont.boldSystemFont(ofSize: 15),
                                   backgroundColor: #colorLiteral(red: 0.9960784314, green: 0.8588235294, blue: 0.1607843137, alpha: 1))
        
        let rs = LabelSwitchConfig(text: "OFF",
                                   textColor:  #colorLiteral(red: 0.6196078431, green: 0.6196078431, blue: 0.6196078431, alpha: 1),
                                   font: UIFont.boldSystemFont(ofSize: 15),
                                   backgroundColor: #colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1))
        
        let size = CGSize(width: 72, height: 32)
        
        let switcher = LabelSwitch(center: .zero, leftConfig: ls, rightConfig: rs, circlePadding: 0, minimumSize: size, defaultState: .L)
        switcher.circleShadow = true
        switcher.fullSizeTapEnabled = true
        switcher.circleColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.7)
        switcher.translatesAutoresizingMaskIntoConstraints = false
        switcher.delegate = self
        
        return switcher
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
    private func configureCell(with data: BlockerModel) {
        iconImageView.image = UIImage(named: data.imageName)
        titleLabel.text = data.title
        subTitleLabel.text = data.subTitle
        
        if !hasActiveSubscription {
            if self.data?.bundle == AppConstants.trackBlockerBundle || self.data?.bundle == AppConstants.malwareBlockerBundle {
                self.swither.isHidden = true
            }
        }
        
        guard let data = self.data else { return }
        guard let blockerState = sharedUserDeafults?.bool(forKey: data.key) else { return }
        
        swither.curState = blockerState ? .R : .L
    }
    
    
    
    //MARK: - Layout Cell
    private func layoutCell() {
        contentView.addSubview(iconImageView)
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subTitleLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 6
        
        
        contentView.addSubview(swither)
        contentView.addSubview(stackView)
        
        iconImageView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 60, height: 72))
            make.centerY.equalTo(contentView.snp.centerY)
            make.left.equalTo(contentView.snp.left).offset(18)
        }
        
        swither.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 72, height: 32))
            make.centerY.equalTo(contentView.snp.centerY)
            make.right.equalTo(contentView.snp.right).offset(-18)
        }
        stackView.snp.makeConstraints { (make) in
            make.centerY.equalTo(iconImageView.snp.centerY)
            make.left.equalTo(iconImageView.snp.right).offset(18)
            make.right.equalTo(swither.snp.left).offset(-10)
        }
        
    }
    
}



extension BlockerTableViewCell: LabelSwitchDelegate {
    func switchChangToState(sender: LabelSwitch) {
        guard let data = self.data else { return}
        switch sender.curState {
        case .L: sharedUserDeafults?.set(false, forKey: data.key)
        case .R: sharedUserDeafults?.set(true, forKey: data.key)
        }
        
        SFContentBlockerManager.reloadContentBlocker(withIdentifier: data.bundle, completionHandler: nil)
    }
}
