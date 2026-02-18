import Foundation
import UIKit

class CreateMonthlyBudgetView: UIView {

    weak var delegate: MonthSelectorViewDelegate?
    weak var viewDelegate: CreateMonthlyBudgetDelegate?

    var selectedMonth: String?
    var selectedYear: Int?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(headerView)
        headerView.addSubview(backButton)
        headerView.addSubview(titleLabel)
        headerView.addSubview(subtitleLabel)
        addSubview(monthYearTextField)
        addSubview(numericValueTextField)
        addSubview(addButton)
        addSubview(budgetsTableView)
        setupConstrains()
    }

    private let headerView: UIView = {

        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()

    private lazy var backButton: UIView = {
        // Create the glass effect view
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        let glassView = UIVisualEffectView(effect: blurEffect)
        glassView.translatesAutoresizingMaskIntoConstraints = false
        glassView.layer.cornerRadius = 20
        glassView.layer.cornerCurve = .continuous
        glassView.clipsToBounds = true

        // Add subtle border
        glassView.layer.borderWidth = 0.5
        glassView.layer.borderColor = UIColor.separator.cgColor

        // Create the button inside the glass view
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false

        // Configure arrow icon
        let config = UIImage.SymbolConfiguration(pointSize: 16, weight: .medium)
        let arrowImage = UIImage(systemName: "chevron.left", withConfiguration: config)
        button.setImage(arrowImage, for: .normal)
        button.tintColor = .label

        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)

        // Add press animation targets
        button.addTarget(self, action: #selector(buttonPressed), for: .touchDown)
        button.addTarget(
            self, action: #selector(buttonReleased),
            for: [.touchUpInside, .touchUpOutside, .touchCancel])

        // Setup hierarchy
        glassView.contentView.addSubview(button)

        // Setup constraints
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: glassView.contentView.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: glassView.contentView.trailingAnchor),
            button.topAnchor.constraint(equalTo: glassView.contentView.topAnchor),
            button.bottomAnchor.constraint(equalTo: glassView.contentView.bottomAnchor),
        ])

        return glassView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Orçamentos Mensal"
        label.textColor = Colors.gray700
        label.font = Typography.titleSM
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Adicione um orçamento mensal"
        label.textColor = Colors.gray500
        label.font = Typography.textSMRegular
        return label
    }()

    @objc
    private func backButtonTapped() {
        viewDelegate?.didTapReturn()
    }

    @objc
    private func buttonPressed() {
        UIView.animate(withDuration: 0.1, delay: 0, options: .allowUserInteraction) {
            self.backButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            self.backButton.alpha = 0.8
        }
    }

    @objc
    private func buttonReleased() {
        UIView.animate(
            withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5,
            options: .allowUserInteraction
        ) {
            self.backButton.transform = .identity
            self.backButton.alpha = 1.0
        }
    }

    let monthYearTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Mês/Ano"
        textField.backgroundColor = Colors.gray200
        textField.layer.cornerRadius = 8
        textField.layer.masksToBounds = true
        textField.layer.borderWidth = 1
        textField.layer.borderColor = Colors.gray300.cgColor
        textField.borderStyle = .roundedRect

        let picker = UIPickerView()
        textField.inputView = picker

        return textField
    }()

    private let numericValueTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Valor"
        textField.backgroundColor = Colors.gray200
        textField.layer.cornerRadius = 8
        textField.layer.masksToBounds = true
        textField.layer.borderWidth = 1
        textField.layer.borderColor = Colors.gray300.cgColor
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        return textField
    }()

    let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Adicionar", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addBudget), for: .touchUpInside)
        return button
    }()

    @objc
    private func addBudget() {
        viewDelegate?.didTapAddBudget(
            monthYear: monthYearTextField.text ?? "",
            budget: numericValueTextField.text ?? ""
        )

    }

    let budgetsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BudgetCell")
        return tableView
    }()

    private func setupConstrains() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 190),
            
            backButton.leadingAnchor.constraint(
                equalTo: headerView.leadingAnchor, constant: 20),
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 40),
            backButton.heightAnchor.constraint(equalToConstant: 40),

            titleLabel.topAnchor.constraint(equalTo: backButton.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 12),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 12),

            monthYearTextField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            monthYearTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            monthYearTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            monthYearTextField.heightAnchor.constraint(equalToConstant: 48),

            numericValueTextField.topAnchor.constraint(
                equalTo: monthYearTextField.bottomAnchor, constant: 20),
            numericValueTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            numericValueTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            numericValueTextField.heightAnchor.constraint(equalToConstant: 40),

            addButton.topAnchor.constraint(
                equalTo: numericValueTextField.bottomAnchor, constant: 20),
            addButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 40),

            budgetsTableView.topAnchor.constraint(
                equalTo: addButton.bottomAnchor, constant: 20),
            budgetsTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            budgetsTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            budgetsTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
