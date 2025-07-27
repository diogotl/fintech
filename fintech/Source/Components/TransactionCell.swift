import Foundation
import UIKit

class TransactionCell: UITableViewCell {

    static let identifier = "TransactionCell"

    private let iconView = UIImageView()
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let amountLabel = UILabel()
    private let arrowImageView = UIImageView()
    private let trashButton = UIButton(type: .system)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with transaction: Transaction) {
        // Ícone por categoria (exemplo simples)
        switch transaction.category {
        case "Shopping": iconView.image = UIImage(systemName: "cart")
        case "Gift": iconView.image = UIImage(systemName: "gift")
        case "Utilities": iconView.image = UIImage(systemName: "doc.text")
        case "Rent": iconView.image = UIImage(systemName: "house")
        case "Salary": iconView.image = UIImage(systemName: "briefcase")
        default: iconView.image = UIImage(systemName: "questionmark")
        }
        iconView.tintColor = UIColor.systemPurple

        titleLabel.text = transaction.title
        titleLabel.font = .boldSystemFont(ofSize: 17)

        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        dateLabel.text = formatter.string(from: transaction.date)
        dateLabel.font = .systemFont(ofSize: 13)
        dateLabel.textColor = .gray

        let isIncome = transaction.amount > 0
        amountLabel.text = String(format: "R$ %.2f", abs(transaction.amount))
        amountLabel.font = .boldSystemFont(ofSize: 17)
        amountLabel.textColor = isIncome ? .systemGreen : .black

        arrowImageView.image = UIImage(systemName: isIncome ? "arrow.up" : "arrow.down")
        arrowImageView.tintColor = isIncome ? .systemGreen : .systemRed

        trashButton.setImage(UIImage(systemName: "trash"), for: .normal)
        trashButton.tintColor = UIColor.systemPurple
    }

    private func setupUI() {
        iconView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        trashButton.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(iconView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(amountLabel)
        contentView.addSubview(arrowImageView)
        contentView.addSubview(trashButton)

        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            iconView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 36),
            iconView.heightAnchor.constraint(equalToConstant: 36),

            titleLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),

            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            amountLabel.trailingAnchor.constraint(
                equalTo: arrowImageView.leadingAnchor, constant: -8),
            amountLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            arrowImageView.trailingAnchor.constraint(
                equalTo: trashButton.leadingAnchor, constant: -8),
            arrowImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrowImageView.widthAnchor.constraint(equalToConstant: 18),
            arrowImageView.heightAnchor.constraint(equalToConstant: 18),

            trashButton.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor, constant: -16),
            trashButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            trashButton.widthAnchor.constraint(equalToConstant: 24),
            trashButton.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
}
