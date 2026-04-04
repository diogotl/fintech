//
//  InputFieldView.swift
//  fintech
//
//  Created by Diogo on 27/02/2026.
//

import UIKit

enum InputFieldType {
    case text
    case email
    case password
}

final class InputFieldView: UIView {

    private let type: InputFieldType
    let textField = UITextField()
    private let errorLabel = UILabel()

    init(type: InputFieldType, placeholder: String) {
        self.type = type
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupUI(placeholder: placeholder)
        setupErrorLabel()
        setupPasswordIfNeeded()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(placeholder: String) {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .font: Typography.input,
                .foregroundColor: Colors.gray500,
            ]
        )
        textField.backgroundColor = Colors.gray200
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = Colors.gray300.cgColor

        addSubview(textField)
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.heightAnchor.constraint(equalToConstant: 48),
        ])
    }

    private func setupErrorLabel() {
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
        errorLabel.textColor = .systemRed
        errorLabel.isHidden = true

        addSubview(errorLabel)

        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(
                equalTo: textField.bottomAnchor,
                constant: 4
            ),
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            errorLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    private func setupPasswordIfNeeded() {
        guard type == .password else { return }
        textField.isSecureTextEntry = true

        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.setImage(UIImage(systemName: "eye.slash"), for: .selected)
        button.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        button.addTarget(
            self,
            action: #selector(togglePasswordVisibility),
            for: .touchUpInside
        )

        textField.rightView = button
        textField.rightViewMode = .always
    }

    @objc private func togglePasswordVisibility(_ sender: UIButton) {
        sender.isSelected.toggle()
        textField.isSecureTextEntry.toggle()
    }

    // MARK: - Public UI methods

    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
        textField.layer.borderColor = UIColor.systemRed.cgColor

        // Optional: animação leve
        UIView.animate(
            withDuration: 0.15,
            animations: { self.layoutIfNeeded() }
        )
    }

    func clearError() {
        errorLabel.isHidden = true
        textField.layer.borderColor = Colors.gray300.cgColor
    }
}
