import UIKit

class NewTransaction: UIView {

    weak var delegate: NewTransactionDelegate?

    private let categories = [
        "Alimentação", "Transporte", "Saúde", "Educação",
        "Entretenimento", "Casa", "Roupas", "Outros",
    ]
    private var selectedCategory = "Alimentação"

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let userName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.gray700
        label.text = "NOVO LANÇAMENTO"
        label.font = Typography.titleXS
        return label
    }()

    private lazy var transactionCategory: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = Colors.gray200
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = Colors.gray300.cgColor
        button.contentHorizontalAlignment = .left
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true

        button.contentEdgeInsets = UIEdgeInsets(
            top: 0,
            left: 40,
            bottom: 0,
            right: 12
        )
        button.setTitleColor(.label, for: .normal)

        let iconImageView = UIImageView(
            image: UIImage(systemName: "folder.fill")
        )
        iconImageView.tintColor = Colors.gray400
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        button.addSubview(iconImageView)

        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(
                equalTo: button.leadingAnchor,
                constant: 12
            ),
            iconImageView.centerYAnchor.constraint(
                equalTo: button.centerYAnchor
            ),
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 20),
        ])

        var menuActions: [UIAction] = []
        for category in categories {
            let action = UIAction(title: category) { [weak self] _ in
                self?.selectedCategory = category
                self?.updateCategoryButton()
            }
            menuActions.append(action)
        }

        let menu = UIMenu(
            title: "Selecione uma categoria",
            children: menuActions
        )
        button.menu = menu
        button.showsMenuAsPrimaryAction = true

        button.setTitle(selectedCategory, for: .normal)

        return button
    }()

    let closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = Colors.gray600
        button.addTarget(
            self,
            action: #selector(handleDismissButtonTap),
            for: .touchUpInside
        )
        return button
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
        textField.heightAnchor.constraint(equalToConstant: 48).isActive = true

        textField.attributedPlaceholder = NSAttributedString(
            string: "Transaction Title",
            attributes: [NSAttributedString.Key.foregroundColor: Colors.gray400]
        )

        return textField
    }()

    @objc
    private func handleDismissButtonTap() {
        delegate?.didTapDismissButton()
    }

    private let transactionAmount: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = Colors.gray200
        textField.layer.cornerRadius = 8
        textField.layer.masksToBounds = true
        textField.layer.borderWidth = 1
        textField.layer.borderColor = Colors.gray300.cgColor
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        textField.heightAnchor.constraint(equalToConstant: 48).isActive = true

        textField.attributedPlaceholder = NSAttributedString(
            string: "Transaction Amount",
            attributes: [NSAttributedString.Key.foregroundColor: Colors.gray400]
        )

        let dollarLabel = UILabel()
        dollarLabel.text = "$"
        dollarLabel.font = Typography.titleXS
        dollarLabel.textColor = Colors.gray600
        dollarLabel.translatesAutoresizingMaskIntoConstraints = false

        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 48))
        leftView.addSubview(dollarLabel)

        NSLayoutConstraint.activate([
            dollarLabel.centerYAnchor.constraint(
                equalTo: leftView.centerYAnchor
            ),
            dollarLabel.leadingAnchor.constraint(
                equalTo: leftView.leadingAnchor,
                constant: 12
            ),
        ])

        textField.leftView = leftView
        textField.leftViewMode = .always

        return textField
    }()

    private let transactionDate: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = Colors.gray200
        containerView.layer.cornerRadius = 8
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = Colors.gray300.cgColor
        containerView.heightAnchor.constraint(equalToConstant: 48).isActive =
            true

        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact

        containerView.addSubview(datePicker)

        NSLayoutConstraint.activate([
            datePicker.leadingAnchor.constraint(
                equalTo: containerView.leadingAnchor,
                constant: 12
            ),
            datePicker.trailingAnchor.constraint(
                equalTo: containerView.trailingAnchor,
                constant: -12
            ),
            datePicker.centerYAnchor.constraint(
                equalTo: containerView.centerYAnchor
            ),
        ])

        return containerView
    }()

    private var datePicker: UIDatePicker {
        return transactionDate.subviews.first as! UIDatePicker
    }

    private lazy var incomeButton: ToogleTypeButton = {
        let button = ToogleTypeButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 100
        button.addTarget(
            self,
            action: #selector(incomeTapped),
            for: .touchUpInside
        )
        return button
    }()

    private lazy var expenseButton: ToogleTypeButton = {
        let button = ToogleTypeButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = 200
        button.addTarget(
            self,
            action: #selector(expenseTapped),
            for: .touchUpInside
        )
        return button
    }()

    private var selectedType: ToogleTypeButtonType? = nil

    private let transactionButton: Button = {
        let button = Button()
        button.configure(title: "Add Transaction")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
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

    private func updateCategoryButton() {
        transactionCategory.setTitle(selectedCategory, for: .normal)
    }

    @objc
    private func addTransactionButtonTapped() {
        delegate?.didTapSaveTransaction(
            title: transactionTitle.text ?? "",
            categoryId: UUID(),
            value: Double(transactionAmount.text ?? "") ?? 0,
            date: datePicker.date,
            type: selectedType ?? .outcome
        )
    }

    @objc
    private func incomeTapped() {
        selectedType = .income
        updateTypeButtons()
    }

    @objc
    private func expenseTapped() {
        selectedType = .outcome
        updateTypeButtons()
    }

    private func updateTypeButtons() {
        incomeButton.configure(type: .income, selectedType: selectedType)
        expenseButton.configure(type: .outcome, selectedType: selectedType)
    }

    private func setupView() {
        backgroundColor = UIColor.systemGray6
        layer.cornerRadius = 16
        layer.masksToBounds = true
        addSubview(contentView)
        contentView.addSubview(stackView)
        addSubview(closeButton)

        let typeStack = UIStackView(arrangedSubviews: [
            incomeButton, expenseButton,
        ])
        typeStack.axis = .horizontal
        typeStack.spacing = 12
        typeStack.distribution = .fillEqually

        let amountAndDateStack = UIStackView(arrangedSubviews: [
            transactionAmount, transactionDate,
        ])
        amountAndDateStack.axis = .horizontal
        amountAndDateStack.spacing = 12
        amountAndDateStack.distribution = .fillEqually

        [
            userName, transactionTitle, transactionCategory, amountAndDateStack,
            typeStack, transactionButton,
        ].forEach {
            stackView.addArrangedSubview($0)
        }

        transactionButton.addTarget(
            self,
            action: #selector(addTransactionButtonTapped),
            for: .touchUpInside
        )

        NSLayoutConstraint.activate([
            closeButton.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -16
            ),
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 20),

            contentView.leadingAnchor.constraint(
                equalTo: leadingAnchor,
                constant: 24
            ),
            contentView.trailingAnchor.constraint(
                equalTo: trailingAnchor,
                constant: -24
            ),
            contentView.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor,
                constant: -20
            ),
            contentView.topAnchor.constraint(
                greaterThanOrEqualTo: topAnchor,
                constant: 24
            ),

            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor
            ),
            stackView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor
            ),
            stackView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor
            ),
        ])

        updateTypeButtons()
    }
}
