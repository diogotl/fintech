import Foundation
import UIKit

class SummaryCardComponent: UIView {

    weak var delegate: SummaryCardComponentDelegate?

    // MARK: - UI Elements

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
        button.tintColor = Colors.gray100
        button.backgroundColor = .clear
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        return button
    }()

    @objc
    private func handleTap() {
        delegate?.didTapSummaryCardSettingsButton()
    }

    let divider: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.gray100.withAlphaComponent(0.1)
        return view
    }()

    let budgetButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Definir orçamento", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(Colors.magenta, for: .normal)
        button.backgroundColor = Colors.magenta.withAlphaComponent(0.1)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = Colors.magenta.cgColor
        button.addTarget(self, action: #selector(handleBudgetButtonTap), for: .touchUpInside)
        return button
    }()

    @objc
    private func handleBudgetButtonTap() {
        delegate?.didTapSummaryCardSettingsButton()
    }

    private let monthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Typography.titleSM
        label.textColor = Colors.gray100
        label.textAlignment = .center
        label.text = ""
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
        label.font = Typography.textSMRegular
        label.textColor = Colors.gray400
        label.text = "Orçamento disponível"
        label.textAlignment = .center
        return label
    }()

    private let balanceValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Typography.titleLG
        label.textColor = Colors.gray100
        label.text = "R$ 0,00"
        label.textAlignment = .center
        return label
    }()

    private let usedExpensesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.text = "Despesas usadas"
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
        label.text = "Limite do orçamento"
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
        progressView.progressTintColor = Colors.magenta
        progressView.trackTintColor = Colors.gray600
        progressView.layer.cornerRadius = 5
        progressView.layer.masksToBounds = true
        progressView.layer.borderWidth = 1
        progressView.clipsToBounds = true
        progressView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return progressView
    }()

    // MARK: - Init

    init() {
        super.init(frame: .zero)
        setupGradientBackground()
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 0.06, green: 0.06, blue: 0.06, alpha: 1).cgColor,  // #0F0F0F
            UIColor(red: 0.18, green: 0.18, blue: 0.18, alpha: 1).cgColor,  // #2D2D2D
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = 12
        layer.insertSublayer(gradientLayer, at: 0)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.sublayers?.first(where: { $0 is CAGradientLayer })?.frame = bounds
    }

    private func setupUI() {
        layer.cornerRadius = 12
        translatesAutoresizingMaskIntoConstraints = false

        addSubview(monthLabel)
        addSubview(settingsButton)
        addSubview(divider)
        addSubview(changeLabel)
        addSubview(balanceLabel)
        addSubview(balanceValue)
        addSubview(budgetButton)
        addSubview(usedExpensesLabel)
        addSubview(usedExpensesValue)
        addSubview(budgetLimitLabel)
        addSubview(budgetLimitValue)
        addSubview(progressView)

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([

            monthLabel.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            monthLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),

            settingsButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            settingsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),

            divider.topAnchor.constraint(equalTo: settingsButton.bottomAnchor, constant: 8),
            divider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            divider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            divider.heightAnchor.constraint(equalToConstant: 1),

            balanceLabel.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 8),
            balanceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            balanceValue.topAnchor.constraint(equalTo: balanceLabel.bottomAnchor, constant: 8),
            balanceValue.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),

            budgetButton.topAnchor.constraint(equalTo: balanceLabel.bottomAnchor, constant: 8),
            budgetButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            budgetButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            budgetButton.heightAnchor.constraint(equalToConstant: 48),

            usedExpensesLabel.topAnchor.constraint(
                equalTo: budgetButton.bottomAnchor, constant: 8),
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
    
    // MARK: - Atualização Dinâmica

    func configure(
        budget: Double, usedExpenses: Double, limit: Double, month: Date, usedPercentage: Double,
        transactions: [Transaction]
    ) {
        if limit == 0.0 {
            budgetLimitValue.text = "∞"
            budgetButton.isHidden = false
            balanceValue.isHidden = true
            return
        }

        budgetLimitValue.text = "$ \(limit)"
        usedExpensesValue.text = "$ \(usedExpenses)"
        balanceValue.text = "$ \(budget)"
        budgetButton.isHidden = true
        balanceValue.isHidden = false

        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "MMMM"
        monthLabel.text = monthFormatter.string(from: month).uppercased()
        progressView.progress = Float(usedPercentage / 100)
    }

    func updateBalance(_ newBalance: String, change: String? = nil) {
        balanceValue.text = newBalance
        if let change = change {
            changeLabel.text = change
            changeLabel.textColor = change.hasPrefix("+") ? .systemGreen : .systemRed
            changeLabel.isHidden = false
        }
    }
}
