import Foundation
import UIKit

class SummaryCardComponent: UIView {

    private let balance: String
    private let change: String?
    private let period: String?

    private let changeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGreen
        label.textAlignment = .center
        return label
    }()

    private let settingsButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "gear"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .clear
        button.layer.cornerRadius = 8
        return button
    }()

    let divider: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()

    private let monthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()

    private let periodLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()

    private let balanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .white
        label.textAlignment = .center

        return label
    }()

    private let balanceValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    private let usedExpensesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.text = "Budget Limit"
        return label
    }()

    private let usedExpensesValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "R$ 0,00"
        return label
    }()

    private let budgetLimitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.text = "Budget Limit"
        return label
    }()

    private let budgetLimitValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "R$ 0,00"
        return label
    }()

    let progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progressTintColor = .systemPink
        progressView.trackTintColor = .lightGray
        progressView.layer.cornerRadius = 5
        progressView.clipsToBounds = true
        return progressView
    }()

    init(balance: String, change: String? = nil, period: String? = nil) {
        self.balance = balance
        self.change = change
        self.period = period

        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .black
        layer.cornerRadius = 12
        translatesAutoresizingMaskIntoConstraints = false

        balanceLabel.text = balance

        progressView.progress = 0.69

        if let change = change {
            changeLabel.text = change
            changeLabel.textColor = change.hasPrefix("+") ? .systemGreen : .systemRed
        } else {
            changeLabel.isHidden = true
        }

        if let period = period {
            periodLabel.text = period
        } else {
            periodLabel.isHidden = true
        }

        addSubview(settingsButton)

        addSubview(divider)

        addSubview(changeLabel)

        addSubview(balanceLabel)
        addSubview(balanceValue)

        addSubview(usedExpensesLabel)
        addSubview(usedExpensesValue)

        addSubview(budgetLimitLabel)
        addSubview(budgetLimitValue)

        addSubview(progressView)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([

            //balanceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            settingsButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            settingsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),

            divider.topAnchor.constraint(equalTo: settingsButton.bottomAnchor, constant: 8),
            divider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            divider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            divider.heightAnchor.constraint(equalToConstant: 1),

            balanceLabel.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 8),
            balanceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            balanceValue.topAnchor.constraint(equalTo: balanceLabel.bottomAnchor, constant: 8),
            balanceValue.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),

            usedExpensesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            usedExpensesLabel.bottomAnchor.constraint(
                equalTo: usedExpensesValue.topAnchor, constant: -16),
            usedExpensesValue.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            usedExpensesValue.bottomAnchor.constraint(
                equalTo: progressView.topAnchor, constant: -16),

            budgetLimitLabel.bottomAnchor.constraint(
                equalTo: budgetLimitValue.topAnchor, constant: -16),
            budgetLimitLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            budgetLimitValue.bottomAnchor.constraint(
                equalTo: progressView.topAnchor, constant: -16),
            budgetLimitValue.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            progressView.leadingAnchor.constraint(equalTo: leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: trailingAnchor),
            progressView.bottomAnchor.constraint(equalTo: bottomAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 8),
        ])
    }

    // Método para atualizar o saldo (útil para animações ou updates dinâmicos)
    func updateBalance(_ newBalance: String, change: String? = nil) {
        balanceLabel.text = newBalance
        if let change = change {
            changeLabel.text = change
            changeLabel.textColor = change.hasPrefix("+") ? .systemGreen : .systemRed
            changeLabel.isHidden = false
        }
    }
}
