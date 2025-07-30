import UIKit

class NewTransaction: UIView {

    weak var delegate: NewTransactionDelegate?
    

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let transactionTitle: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Transaction Title"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = Colors.gray200
        textField.layer.cornerRadius = 8
        textField.layer.masksToBounds = true
        textField.layer.borderWidth = 1
        textField.layer.borderColor = Colors.gray300.cgColor
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let transactionCategory: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Transaction Category"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = Colors.gray200
        textField.layer.cornerRadius = 8
        textField.layer.masksToBounds = true
        textField.layer.borderWidth = 1
        textField.layer.borderColor = Colors.gray300.cgColor
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let transactionAmount: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Transaction Amount"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = Colors.gray200
        textField.layer.cornerRadius = 8
        textField.layer.masksToBounds = true
        textField.layer.borderWidth = 1
        textField.layer.borderColor = Colors.gray300.cgColor
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        return textField
    }()

    private let transactionDate: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        return datePicker
    }()

    private let incomeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Income", for: .normal)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = Colors.gray300.cgColor
        button.backgroundColor = Colors.gray200
        button.setTitleColor(.systemGreen, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let expenseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Expense", for: .normal)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = Colors.gray300.cgColor
        button.backgroundColor = Colors.gray200
        button.setTitleColor(.systemRed, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var selectedType: String = "income"

    private let transactionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add Transaction", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.systemBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 10
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    @objc
    private func addTransactionButtonTapped() {
        let transaction = Transaction(
            title: transactionTitle.text ?? "",
            category: transactionCategory.text ?? "",
            amount: Double(transactionAmount.text ?? "") ?? 0.0,
            type: selectedType,
            date: transactionDate.date
        )
        delegate?.didTapSaveTransaction(transaction: transaction)
    }

    @objc
    private func incomeTapped() {
        selectedType = "income"
        updateTypeButtons()
    }

    @objc
    private func expenseTapped() {
        selectedType = "expense"
        updateTypeButtons()
    }

    private func updateTypeButtons() {
        if selectedType == "income" {
            incomeButton.backgroundColor = .systemGreen
            incomeButton.setTitleColor(.white, for: .normal)
            expenseButton.backgroundColor = Colors.gray200
            expenseButton.setTitleColor(.systemRed, for: .normal)
        } else {
            expenseButton.backgroundColor = .systemRed
            expenseButton.setTitleColor(.white, for: .normal)
            incomeButton.backgroundColor = Colors.gray200
            incomeButton.setTitleColor(.systemGreen, for: .normal)
        }
    }

    private func setupView() {
        backgroundColor = UIColor.systemGray6
        layer.cornerRadius = 16
        layer.masksToBounds = true
        addSubview(stackView)

        let typeStack = UIStackView(arrangedSubviews: [incomeButton, expenseButton])
        typeStack.axis = .horizontal
        typeStack.spacing = 12
        typeStack.distribution = .fillEqually

        [transactionTitle, transactionCategory, transactionAmount, transactionDate, typeStack, transactionButton].forEach {
            stackView.addArrangedSubview($0)
        }

        incomeButton.addTarget(self, action: #selector(incomeTapped), for: .touchUpInside)
        expenseButton.addTarget(self, action: #selector(expenseTapped), for: .touchUpInside)
        transactionButton.addTarget(self, action: #selector(addTransactionButtonTapped), for: .touchUpInside)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -32)
        ])

        updateTypeButtons()
    }
}
