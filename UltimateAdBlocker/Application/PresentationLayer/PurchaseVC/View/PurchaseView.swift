
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
        indicator.color = #colorLiteral(red: 0.9960784314, green: 0.8588235294, blue: 0.1607843137, alpha: 1)
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        return indicator
    }()
    
    private let subscribeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Subscribe".uppercased()
        label.font = Fonts.robotoRegular.of(size: 22)
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.textAlignment = .center
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.robotoRegular.of(size: 15)
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
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
        
        self.layer.cornerRadius = 30
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 10
        
    }
    
    //MARK: SetupView
    private func setupView() {
        backgroundColor = #colorLiteral(red: 0.1254901961, green: 0.1137254902, blue: 0.1803921569, alpha: 1)
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
