
import UIKit

class LoadingCircleViewController: UIViewController {
    
    //MARK: -
    //MARK: - Views
    private let loadingIndicator: LoadingCircleView = {
        let progress = LoadingCircleView(colors: [#colorLiteral(red: 0.9960784314, green: 0.8588235294, blue: 0.1607843137, alpha: 1), #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), #colorLiteral(red: 0.9960784314, green: 0.8588235294, blue: 0.1607843137, alpha: 1)], lineWidth: 3, circleRadius: 25)
         progress.translatesAutoresizingMaskIntoConstraints = false
         return progress
     }()

    //MARK: -
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()

    }
    
    //MARK: -
    //MARK: - SetupView
    private func setupView() {
        layoutView() 
        loadingIndicator.isAnimating = true
    
        view.backgroundColor = .clear
    }
    
    
    //MARK: -
    //MARK: - Layout
    private func layoutView() {
        view.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            loadingIndicator.widthAnchor.constraint(equalToConstant: 100),
            loadingIndicator.heightAnchor.constraint(equalTo: self.loadingIndicator.widthAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    

}
