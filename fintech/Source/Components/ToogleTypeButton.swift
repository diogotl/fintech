//
//  ToogleTypeButton.swift
//  fintech
//
//  Created by Diogo on 17/02/2026.
//

import UIKit

enum ToogleTypeButtonType {
    case income
    case outcome
}

class ToogleTypeButton: UIButton {

    private static let buttonConfigurations:
        [ToogleTypeButtonType: [String: Any]] =
            [
                .income: [
                    "title": "Income",
                    "titleColor": UIColor.systemGreen,
                    "backgroundColor": Colors.gray200,
                    "icon": "arrowtriangle.up.fill",
                    "iconColor": UIColor.systemGreen,
                    "color": Colors.green,
                ],
                .outcome: [
                    "title": "Expense",
                    "titleColor": UIColor.systemRed,
                    "backgroundColor": Colors.gray200,
                    "icon": "arrowtriangle.down.fill",
                    "iconColor": UIColor.systemRed,
                    "color": Colors.red,
                ],
            ]

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {

        self.titleLabel?.font = Typography.buttonSM
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 2
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 48).isActive = true
    }

    func configure(
        type: ToogleTypeButtonType,
        selectedType: ToogleTypeButtonType?
    ) {
        let isSelected = (type == selectedType)

        guard let config = Self.buttonConfigurations[type] else { return }

        var buttonConfig = UIButton.Configuration.plain()

        buttonConfig.title = config["title"] as? String ?? "Error"
        buttonConfig.titleTextAttributesTransformer =
            UIConfigurationTextAttributesTransformer {
                attributes in
                var newAttributes = attributes
                newAttributes.font = Typography.buttonSM
                return newAttributes
            }

        if let iconName = config["icon"] as? String {
            buttonConfig.image = UIImage(systemName: iconName)
            buttonConfig.imagePlacement = .trailing
            buttonConfig.imagePadding = 8
        }

        let primaryColor = config["color"] as! UIColor

        if isSelected {
            buttonConfig.background.backgroundColor = primaryColor
            buttonConfig.baseForegroundColor = .white
            layer.borderColor = primaryColor.cgColor
        } else {
            buttonConfig.background.backgroundColor = Colors.gray200
            buttonConfig.baseForegroundColor = primaryColor

            if selectedType == nil {
                layer.borderColor = primaryColor.cgColor
            } else {
                layer.borderColor = UIColor.clear.cgColor
            }
        }

        self.configuration = buttonConfig
    }
}
