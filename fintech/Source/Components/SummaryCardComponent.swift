import Foundation
import UIKit

class SummaryCardComponent: UIView {

    private let balance: String
    private let change: String?
    private let period: String?

    private let balanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    private let changeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()

    private let periodLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
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

        // Configurar dados
        balanceLabel.text = balance

        if let change = change {
            changeLabel.text = change
            // Verde para positivo, vermelho para negativo
            changeLabel.textColor = change.hasPrefix("+") ? .systemGreen : .systemRed
        } else {
            changeLabel.isHidden = true
        }

        if let period = period {
            periodLabel.text = period
        } else {
            periodLabel.isHidden = true
        }

        addSubview(balanceLabel)
        addSubview(changeLabel)
        addSubview(periodLabel)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            balanceLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            balanceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            balanceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            changeLabel.topAnchor.constraint(equalTo: balanceLabel.bottomAnchor, constant: 8),
            changeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            changeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            periodLabel.topAnchor.constraint(equalTo: changeLabel.bottomAnchor, constant: 8),
            periodLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            periodLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            periodLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
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
