//
//  HelpViewController.swift
//  UltimateAdBlocker
//
//  Created by Pavel Buzdanov on 03.03.2021.
//

import UIKit

class HelpViewController: UIViewController {
    
    
    private let blurView: UIVisualEffectView = {
        let view = UIVisualEffectView()
        let effect = UIBlurEffect(style: .dark)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.effect = effect
        return view
    }()
    
    
    private let whiteView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return view
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "closeButton"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Help with Subscription"
        label.font = Fonts.comfortaaBold.of(size: 20)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Contact Email"
        label.font = Fonts.comfortaaBold.of(size: 20)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = .left
        return label
    }()
    
    private let descripeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Describe problem"
        label.font = Fonts.comfortaaBold.of(size: 20)
        label.adjustsFontSizeToFitWidth = true
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var emailTextField: TextField = {
        let field = TextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = Fonts.robotoRegular.of(size: 16)
        field.keyboardType = .emailAddress
        field.backgroundColor = #colorLiteral(red: 0.8745098039, green: 0.8862745098, blue: 0.9215686275, alpha: 1)
        field.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        field.placeholder = "Enter email"
        field.delegate = self
        return field
    }()
    
    private lazy var describeTextField: UITextView = {
        let field = UITextView()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = Fonts.robotoRegular.of(size: 16)
        field.keyboardType = .default
        field.backgroundColor = #colorLiteral(red: 0.8745098039, green: 0.8862745098, blue: 0.9215686275, alpha: 1)
        field.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        field.delegate = self
        return field
    }()
    
    private let sendButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("SEND", for: .normal)
        button.titleLabel?.font = Fonts.robotoBold.of(size: 18)
        button.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.8588235294, blue: 0.1607843137, alpha: 1)
        button.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    
    //MARK: - SetupView
    private func setupView(){
        layoutView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        sendButton.layer.cornerRadius = 12
        sendButton.clipsToBounds = true
        
        emailTextField.layer.cornerRadius = 12
        emailTextField.clipsToBounds = true
        
        describeTextField.layer.cornerRadius = 12
        describeTextField.clipsToBounds = true
        
        whiteView.layer.cornerRadius = 12
        whiteView.clipsToBounds = true
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    //MARK: - Private
    @objc private func closeButtonTapped() {
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    @objc private func sendButtonTapped() {
     
        guard let textFieldText = self.emailTextField.text else { return self.showAlertWithMassage("Error", "Invalid Email") }
        let count = self.describeTextField.text.count
        
        if count == 0 {
       
            self.showAlertWithMassage("Error", "Please, describe the problem")
            
        }
        
        if textFieldText.isEmail() {
            let alert = UIAlertController(title: "Excellent", message: "We will definitely answer you within 10 days.", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Ok", style: .cancel) { (_) in
                self.view.removeFromSuperview()
                self.removeFromParent()
                self.emailLabel.text = ""
                self.describeTextField.text = ""
            }
            
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        } else {
            self.showAlertWithMassage("Error", "Wrong Email")
        }
    }
    
    
    //MARK: - LayoutView
    private func layoutView() {
        view.addSubview(blurView)
        view.addSubview(closeButton)
        view.addSubview(whiteView)
        view.addSubview(sendButton)
        
        whiteView.addSubview(titleLabel)
        whiteView.addSubview(emailLabel)
        whiteView.addSubview(emailTextField)
        whiteView.addSubview(descripeLabel)
        whiteView.addSubview(describeTextField)
        
        blurView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.snp.edges)
        }
        
        whiteView.snp.makeConstraints { (make) in
            make.width.equalTo(view.bounds.size.width-60)
            make.height.equalTo(whiteView.snp.width)
            make.center.equalTo(view.snp.center)
        }
        
        sendButton.snp.makeConstraints { (make) in
            make.width.equalTo(view.bounds.size.width-60)
            make.height.equalTo(60)
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(whiteView.snp.bottom).offset(20)
        }
        
        
        closeButton.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 30, height: 30))
            make.left.equalTo(view.snp.left).offset(20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(whiteView.snp.left).offset(20)
            make.right.equalTo(whiteView.snp.right).offset(-20)
            make.centerX.equalTo(whiteView.snp.centerX)
            make.top.equalTo(whiteView.snp.top).offset(10)
        }
        
        emailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.equalTo(whiteView.snp.left).offset(20)
        }
        
        emailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(emailLabel.snp.bottom).offset(10)
            make.height.equalTo(40)
            make.left.equalTo(whiteView.snp.left).offset(20)
            make.right.equalTo(whiteView.snp.right).offset(-20)
        }
        
        descripeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom).offset(10)
            make.left.equalTo(whiteView.snp.left).offset(20)
        }
        
        
        describeTextField.snp.makeConstraints { (make) in
            make.top.equalTo(descripeLabel.snp.bottom).offset(10)
            make.bottom.equalTo(whiteView.snp.bottom).offset(-10)
            make.left.equalTo(whiteView.snp.left).offset(20)
            make.right.equalTo(whiteView.snp.right).offset(-20)
        }
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height/2
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    
}


//MARK: - UITextFieldDelegate
extension HelpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          textField.resignFirstResponder() // dismiss keyboard
          return true
      }
    
}

//MARK: - UITextViewDelegate
extension HelpViewController: UITextViewDelegate {
   
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if let character = text.first, character.isNewline {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
}
