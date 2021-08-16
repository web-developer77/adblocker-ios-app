
import UIKit

class LoadingCircleView: UIView {
    
    //MARK: -
    //MARK: - Properties
    
    var isAnimating: Bool = false {
        didSet {
            if isAnimating {
                self.animateStroke()
                self.animateRotation()
            } else {
                self.shapeLayer.removeFromSuperlayer()
                self.layer.removeAllAnimations()
            }
        }
    }
    
    let colors: [UIColor]
    let lineWidth: CGFloat
    
    let circleRadius: CGFloat
    
    private var blurView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .extraLight)
        let view = UIVisualEffectView(effect: effect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var shapeLayer: LoadingShapeLayer = {
        return LoadingShapeLayer(strokeColor: colors.first!, lineWidth: lineWidth)
    }()

    //MARK: -
    //MARK: - Init
    init(frame: CGRect, colors: [UIColor], lineWidth: CGFloat,circleRadius: CGFloat) {
        self.colors = colors
        self.lineWidth = lineWidth
        self.circleRadius = circleRadius
        
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        layoutView()
        
    }
    
    convenience init(colors: [UIColor], lineWidth: CGFloat, circleRadius: CGFloat) {
        self.init(frame: .zero, colors: colors, lineWidth: lineWidth, circleRadius: circleRadius)
        layoutView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -
    //MARK: - LayoutSubviews
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 4
        self.blurView.layer.cornerRadius = 4
        self.blurView.clipsToBounds = true
        
        
        let circlePath = UIBezierPath(arcCenter: .zero, radius: self.circleRadius, startAngle: 0, endAngle:  CGFloat.pi * 2, clockwise: true)
        
        shapeLayer.path = circlePath.cgPath
        shapeLayer.position = CGPoint(x: self.bounds.width/2, y: self.bounds.height/2)
        self.layer.addSublayer(shapeLayer)
        
    }
    
    //MARK: -
    //MARK: - LayoutView
    private func layoutView() {
        addSubview(blurView)
        
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            blurView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            blurView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            blurView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
    
    
    //MARK: -
    //MARK: - Animation
    private func animateStroke() {
        
        let startAnimation = StrokeAnimation(type: .start, beginTime: 0.25, fromValue: 0.0, toValue: 1.0, duration: 0.75)
        
        let endAnimation = StrokeAnimation(type: .end, beginTime: 0.0, fromValue: 0.0, toValue: 1.0, duration: 0.75)
        
        let strokeAnimationGroup = CAAnimationGroup()
        strokeAnimationGroup.duration = 1.0
        strokeAnimationGroup.repeatDuration = .infinity
        strokeAnimationGroup.animations = [startAnimation, endAnimation]
        
        
        let colorAnimation = StrokeColorAnimation(
            colors: colors.map { $0.cgColor },
            duration: strokeAnimationGroup.duration * Double(colors.count)
        )

        shapeLayer.add(colorAnimation, forKey: nil)
        
        shapeLayer.add(strokeAnimationGroup, forKey: nil)
    }
    
    private func animateRotation() {
        let rotationAnimation = RotationAnimation(
            direction: .z,
            fromValue: 0,
            toValue: CGFloat.pi * 2,
            duration: 2,
            repeatCount: .greatestFiniteMagnitude
        )
        
        self.shapeLayer .add(rotationAnimation, forKey: nil)
    }
    
    
    
}
