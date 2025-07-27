import Foundation
import UIKit

class SignUpView: UIView {
    
    weak var delegate: SignUpViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = .white
        addSubview(logoImageView)
        addSubview(welcomeText)
        addSubview(welcomeDescription)
        addSubview(nameTextField)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(signUpButton)
        setupConstrains()
    }

    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "image")
        return imageView
    }()

    private let welcomeText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome to Fintech App"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        return label
    }()

    private let welcomeDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Create your account to start managing your finances."
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()

    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Name"
        textField.backgroundColor = Colors.gray200
        textField.layer.cornerRadius = 8
        textField.layer.masksToBounds = true
        textField.layer.borderWidth = 1
        textField.layer.borderColor = Colors.gray300.cgColor
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Email"
        textField.backgroundColor = Colors.gray200
        textField.layer.cornerRadius = 8
        textField.layer.masksToBounds = true
        textField.layer.borderWidth = 1
        textField.layer.borderColor = Colors.gray300.cgColor
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        textField.backgroundColor = Colors.gray200
        textField.layer.cornerRadius = 8
        textField.layer.masksToBounds = true
        textField.layer.borderWidth = 1
        textField.layer.borderColor = Colors.gray300.cgColor
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
       
        
        let eyeButton = UIButton(type: .custom)
        eyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
        eyeButton.setImage(UIImage(systemName: "eye.slash"), for: .selected)
        eyeButton.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        eyeButton.addTarget(nil, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        textField.rightView = eyeButton
        textField.rightViewMode = .always
        return textField
    }()

    @objc private func togglePasswordVisibility(_ sender: UIButton) {
        sender.isSelected.toggle()
        passwordTextField.isSecureTextEntry.toggle()
    }

    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = Colors.magenta
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(signUpButtonTapped), for:.touchUpInside)
        button.layer.cornerRadius = 8
        return button
    }()
    
    @objc
    private func signUpButtonTapped() {
        delegate?.didTapSignUpButton(
            username: nameTextField.text ?? "",
            password: passwordTextField.text ?? "",
            email: emailTextField.text ?? "",
        )
    }

    func setupConstrains() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            logoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            logoImageView.heightAnchor.constraint(equalToConstant: 359),

            welcomeText.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 16),
            welcomeText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            welcomeText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            welcomeText.centerXAnchor.constraint(equalTo: centerXAnchor),
            welcomeText.heightAnchor.constraint(equalToConstant: 30),
            
            welcomeDescription.topAnchor.constraint(equalTo: welcomeText.bottomAnchor, constant: 8),
            welcomeDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            welcomeDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            welcomeDescription.centerXAnchor.constraint(equalTo: centerXAnchor),

            nameTextField.topAnchor.constraint(equalTo: welcomeDescription.bottomAnchor, constant: 16),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            nameTextField.heightAnchor.constraint(equalToConstant: 48),

            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 8),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            emailTextField.heightAnchor.constraint(equalToConstant: 48),

            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 8),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            passwordTextField.heightAnchor.constraint(equalToConstant: 48),

            signUpButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            signUpButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            signUpButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            signUpButton.heightAnchor.constraint(equalToConstant: 48),

        ])

    }

}
