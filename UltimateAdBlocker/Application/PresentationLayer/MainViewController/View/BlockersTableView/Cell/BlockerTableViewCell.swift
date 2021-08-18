//
//  BlockerTableViewCell.swift
//  UltimateAdBlocker
//
//  Created by Pavel Buzdanov on 02.03.2021.
//

import UIKit
import LabelSwitch
import SafariServices

protocol BlockTableViewCellDelegate {
    func didChangeSwitch()
}

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
    
    var delegate: BlockTableViewCellDelegate?
    
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
        view.backgroundColor = UIColor.instantinate(from: .secondaryYellow)
        view.layer.cornerRadius = 16.0
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.montserratSemiBold.of(size: 18)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.montserratRegular.of(size: 14)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        return label
    }()
    
    
    private lazy var swither: LabelSwitch = {
        let ls = LabelSwitchConfig(text: "ON",
                                   textColor: .white,
                                   font: Fonts.montserratSemiBold.of(size: 12.0)!,
                                   backgroundColor: .black)
        
        let rs = LabelSwitchConfig(text: "OFF",
                                   textColor:  .white,
                                   font: Fonts.montserratSemiBold.of(size: 12.0)!,
                                   backgroundColor: .black)
        
        let size = CGSize(width: 62, height: 28)
        
        let switcher = LabelSwitch(center: .zero, leftConfig: ls, rightConfig: rs, circlePadding: 0, minimumSize: size, defaultState: .L)
        switcher.layer.borderWidth = 1.0
        switcher.layer.borderColor = UIColor.black.cgColor
        switcher.circleShadow = true
        switcher.fullSizeTapEnabled = true
        switcher.circleColor = UIColor.instantinate(from: .mainYellow)
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
        container.addSubview(iconImageView)
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subTitleLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 6
        
        
        container.addSubview(swither)
        container.addSubview(stackView)
        
        iconImageView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.centerY.equalTo(container.snp.centerY)
            make.left.equalTo(container.snp.left).offset(18)
        }
        
        swither.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 62, height: 28))
            make.centerY.equalTo(container.snp.centerY)
            make.right.equalTo(container.snp.right).offset(-18)
        }
        stackView.snp.makeConstraints { (make) in
            make.centerY.equalTo(iconImageView.snp.centerY)
            make.left.equalTo(iconImageView.snp.right).offset(18)
            make.right.equalTo(swither.snp.left).offset(-10)
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



extension BlockerTableViewCell: LabelSwitchDelegate {
    func switchChangToState(sender: LabelSwitch) {
        guard let data = self.data else { return}
        if hasActiveSubscription {
            switch sender.curState {
            case .L: sharedUserDeafults?.set(false, forKey: data.key)
            case .R: sharedUserDeafults?.set(true, forKey: data.key)
            }
            
            SFContentBlockerManager.reloadContentBlocker(withIdentifier: data.bundle, completionHandler: nil)
        } else {
            delegate?.didChangeSwitch()
        }
    }
}
