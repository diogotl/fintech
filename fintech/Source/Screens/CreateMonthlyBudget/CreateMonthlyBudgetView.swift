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
        addSubview(monthYearTextField)
        addSubview(numericValueTextField)
        addSubview(addButton)
        addSubview(budgetsTableView)
        setupConstrains()
    }
    
    private let headerView: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        return view
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("<", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Orçamentos Mensal"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Adicione um orçamento mensal"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    @objc
    private func backButtonTapped(){
        viewDelegate?.didTapReturn()
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
            headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 100),
            
            backButton.leadingAnchor.constraint(
                equalTo: headerView.leadingAnchor, constant: 20),
            
            monthYearTextField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            monthYearTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            monthYearTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            monthYearTextField.heightAnchor.constraint(equalToConstant: 150),

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
