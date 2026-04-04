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
        addSubview(nameField)
        addSubview(emailField)
        addSubview(passwordField)
        addSubview(divider)
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
        label.font = Typography.titleSM
        label.textColor = Colors.gray700
        return label
    }()

    private let welcomeDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Create your account to start managing your finances."
        label.font = Typography.textXS
        label.textColor = Colors.gray500
        return label
    }()

    let nameField = InputFieldView(type: .text, placeholder: "Name")
    let emailField = InputFieldView(type: .email, placeholder: "Email")
    let passwordField = InputFieldView(
        type: .password,
        placeholder: "Password"
    )

    //    private let nameTextField: UITextField = {
    //        let textField = UITextField()
    //        textField.translatesAutoresizingMaskIntoConstraints = false
    //        textField.attributedPlaceholder = NSAttributedString(
    //            string: "Name",
    //            attributes: [
    //                .font: Typography.input, .foregroundColor: Colors.gray500,
    //            ]
    //        )
    //        textField.backgroundColor = Colors.gray200
    //        textField.layer.cornerRadius = 8
    //        textField.layer.masksToBounds = true
    //        textField.layer.borderWidth = 1
    //        textField.layer.borderColor = Colors.gray300.cgColor
    //        textField.borderStyle = .roundedRect
    //        return textField
    //    }()

    //    private let emailTextField: UITextField = {
    //        let textField = UITextField()
    //        textField.translatesAutoresizingMaskIntoConstraints = false
    //        textField.attributedPlaceholder = NSAttributedString(
    //            string: "Email",
    //            attributes: [
    //                .font: Typography.input, .foregroundColor: Colors.gray600,
    //            ]
    //        )
    //        textField.backgroundColor = Colors.gray200
    //        textField.layer.cornerRadius = 8
    //        textField.layer.masksToBounds = true
    //        textField.layer.borderWidth = 1
    //        textField.layer.borderColor = Colors.gray300.cgColor
    //        textField.borderStyle = .roundedRect
    //        return textField
    //    }()

    //    private let passwordTextField: UITextField = {
    //        let textField = UITextField()
    //        textField.translatesAutoresizingMaskIntoConstraints = false
    //        textField.attributedPlaceholder = NSAttributedString(
    //            string: "Password",
    //            attributes: [
    //                .font: Typography.input, .foregroundColor: Colors.gray600,
    //            ]
    //        )
    //        textField.backgroundColor = Colors.gray200
    //        textField.layer.cornerRadius = 8
    //        textField.layer.masksToBounds = true
    //        textField.layer.borderWidth = 1
    //        textField.layer.borderColor = Colors.gray300.cgColor
    //        textField.borderStyle = .roundedRect
    //        textField.isSecureTextEntry = true
    //
    //        let eyeButton = UIButton(type: .custom)
    //        eyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
    //        eyeButton.setImage(UIImage(systemName: "eye.slash"), for: .selected)
    //        eyeButton.frame = CGRect(x: -4, y: 0, width: 24, height: 24)
    //        eyeButton.addTarget(
    //            nil,
    //            action: #selector(togglePasswordVisibility),
    //            for: .touchUpInside
    //        )
    //        textField.rightView = eyeButton
    //        textField.rightViewMode = .always
    //        textField.textColor = Colors.gray700
    //        return textField
    //    }()

    //    @objc private func togglePasswordVisibility(_ sender: UIButton) {
    //        sender.isSelected.toggle()
    //        passwordTextField.isSecureTextEntry.toggle()
    //    }

    private lazy var divider: UIView = {
        let divider = UIView()
        divider.translatesAutoresizingMaskIntoConstraints = false
        divider.backgroundColor = Colors.gray500
        return divider

    }()

    private lazy var signUpButton: Button = {
        let button = Button()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(
            self,
            action: #selector(signUpButtonTapped),
            for: .touchUpInside
        )
        button.configure(title: "Create Account")
        return button
    }()

    @objc
    private func signUpButtonTapped() {
        delegate?.didTapSignUpButton(
            username: nameField.textField.text ?? "",
            password: passwordField.textField.text ?? "",
            email: emailField.textField.text ?? "",
        )
    }

    func clearAllErrors() {
        nameField.clearError()
        passwordField.clearError()
        emailField.clearError()
    }

    func setupConstrains() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor
            ),
            logoImageView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 4
            ),
            logoImageView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -4
            ),
            logoImageView.heightAnchor.constraint(equalToConstant: 400),

            welcomeText.topAnchor.constraint(
                equalTo: logoImageView.bottomAnchor,
                constant: 16
            ),
            welcomeText.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16
            ),
            welcomeText.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16
            ),

            welcomeDescription.topAnchor.constraint(
                equalTo: welcomeText.bottomAnchor,
                constant: 8
            ),
            welcomeDescription.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 16
            ),
            welcomeDescription.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16
            ),

            nameField.topAnchor.constraint(
                equalTo: welcomeDescription.bottomAnchor,
                constant: 16
            ),
            nameField.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 24
            ),
            nameField.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -24
            ),
//            nameField.heightAnchor.constraint(equalToConstant: 48),

            emailField.topAnchor.constraint(
                equalTo: nameField.bottomAnchor,
                constant: 12
            ),
            emailField.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 24
            ),
            emailField.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -24
            ),
//            emailField.heightAnchor.constraint(equalToConstant: 48),

            passwordField.topAnchor.constraint(
                equalTo: emailField.bottomAnchor,
                constant: 12
            ),
            passwordField.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 24
            ),
            passwordField.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -24
            ),
//            passwordField.heightAnchor.constraint(equalToConstant: 48),

            divider.leadingAnchor.constraint(
                equalTo: signUpButton.leadingAnchor
            ),
            divider.bottomAnchor.constraint(
                equalTo: signUpButton.topAnchor,
                constant: 16
            ),
            divider.trailingAnchor.constraint(
                equalTo: signUpButton.trailingAnchor,
            ),
            divider.heightAnchor.constraint(equalToConstant: 2),

            signUpButton.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor,
                constant: -16
            ),
            signUpButton.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 24
            ),
            signUpButton.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -24
            ),
            signUpButton.heightAnchor.constraint(equalToConstant: 48),

        ])

    }

}
