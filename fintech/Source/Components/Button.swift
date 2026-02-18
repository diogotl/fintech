//
//  Button.swift
//  fintech
//
//  Created by Diogo on 17/02/2026.
//

import UIKit

class Button: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Colors.magenta
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 8
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    }

    func configure(title: String) {
        setTitle(title, for: .normal)
    }
}
