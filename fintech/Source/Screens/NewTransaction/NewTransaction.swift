//
//  NewTransaction.swift
//  fintech
//
//  Created by Diogo on 20/07/2025.
//

import Foundation
import UIKit

class NewTransaction: UIView {
    
    weak var delegate: NewTransactionDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    
    let transactionTitle: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Transaction Title"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let transactionCategory: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Transaction Category"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let transactionAmount: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Transaction Amount"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    let transactionDate: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date
        return datePicker
    }()
    
    let transactionType: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Income", "Expense"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    let transactionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add Transaction", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(addTransactionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    @objc
    func addTransactionButtonTapped() {
        
        let transaction = Transaction(
            title: transactionTitle.text ?? "",
            category: transactionCategory.text ?? "",
            amount: Double(transactionAmount.text ?? "") ?? 0.0,
            type: transactionType.selectedSegmentIndex == 0 ? "income" : "expense",
            date: transactionDate.date,
        )
       
        delegate?.didTapSaveTransaction(transaction: transaction)
    }

    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 16
        addSubview(transactionTitle)
        addSubview(transactionCategory)
        addSubview(transactionAmount)
        addSubview(transactionDate)
        addSubview(transactionType)
        addSubview(transactionButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            transactionTitle.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            transactionTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            transactionTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            transactionCategory.topAnchor.constraint(equalTo: transactionTitle.bottomAnchor, constant: 10),
            transactionCategory.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            transactionCategory.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            transactionAmount.topAnchor.constraint(equalTo: transactionCategory.bottomAnchor, constant: 10),
            transactionAmount.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            transactionAmount.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            transactionDate.topAnchor.constraint(equalTo: transactionAmount.bottomAnchor, constant: 10),
            transactionDate.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            transactionDate.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            
            transactionType.topAnchor.constraint(equalTo: transactionDate.bottomAnchor, constant: 10),
            transactionType.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            transactionType.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            transactionButton.topAnchor.constraint(equalTo: transactionType.bottomAnchor, constant: 20),
            transactionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            transactionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            transactionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)

        ])
    }
}
