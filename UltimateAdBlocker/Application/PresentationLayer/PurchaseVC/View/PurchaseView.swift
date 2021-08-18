
import UIKit


class PurchaseView: UIView {
    
    //MARK: Views
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false

        if #available(iOS 13.0, *) {
            indicator.style = .large
        }
        
        indicator.isUserInteractionEnabled = true
        indicator.color = .white
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        return indicator
    }()
    
    private let subscribeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Unlock Full Version".uppercased()
        label.font = Fonts.montserratSemiBold.of(size: 20)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.montserratSemiBold.of(size: 20)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.shadowRadius = 10
        
    }
    
    //MARK: SetupView
    private func setupView() {
        backgroundColor = UIColor.instantinate(from: .mainYellow)
        layer.cornerRadius = 12.0
        layoutView()
        showIndicator()
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    //MARK: Layout
    fileprivate func layoutView() {
        addSubview(subscribeLabel)
        addSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            subscribeLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            subscribeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 19),
            
            priceLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            priceLabel.topAnchor.constraint(equalTo: subscribeLabel.bottomAnchor, constant: 3),
            
        ])
    }
    
    //MARK: Public
    public func hideIndicator() {
        priceLabel.isHidden = false
        subscribeLabel.isHidden = false
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
    
    
    public func showIndicator() {
        priceLabel.isHidden = true
        subscribeLabel.isHidden = true
      
        self.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
