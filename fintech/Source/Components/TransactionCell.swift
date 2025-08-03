import Foundation
import UIKit

class TransactionCell: UITableViewCell {

    static let identifier = "TransactionCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let iconBackgroundView: UIView = {
        let iconBackgroundView = UIView()
        iconBackgroundView.backgroundColor = Colors.gray200
        iconBackgroundView.layer.cornerRadius = 6
        iconBackgroundView.layer.masksToBounds = true
        iconBackgroundView.layer.borderWidth = 1
        iconBackgroundView.layer.borderColor = Colors.gray300.cgColor
        iconBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        iconBackgroundView.contentMode = .scaleAspectFit
        return iconBackgroundView
    }()
    
    private let iconView: UIImageView = {
        let iconView = UIImageView()
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.contentMode = .scaleAspectFit
        iconView.tintColor = Colors.magenta
        return iconView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Typography.textSMBold
        label.textColor = Colors.gray700
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Typography.textXS
        label.textColor = Colors.gray500
        return label
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Typography.titleMD
        label.textColor = Colors.gray700
        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Colors.gray500
        return imageView
    }()
    
    private let trashButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = Colors.gray500
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.addTarget(self, action: #selector(trashButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc
    private func trashButtonTapped() {
        // Handle trash button tap
    }
    
    private func setupUI() {
        contentView.addSubview(iconBackgroundView)
        iconBackgroundView.addSubview(iconView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(amountLabel)
        contentView.addSubview(arrowImageView)
        contentView.addSubview(trashButton)

        NSLayoutConstraint.activate([
            iconBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            iconBackgroundView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconBackgroundView.widthAnchor.constraint(equalToConstant: 36),
            iconBackgroundView.heightAnchor.constraint(equalToConstant: 36),
            
            iconView.centerXAnchor.constraint(equalTo: iconBackgroundView.centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: iconBackgroundView.centerYAnchor),

            titleLabel.leadingAnchor.constraint(equalTo: iconBackgroundView.trailingAnchor, constant: 12),
            titleLabel.topAnchor.constraint(equalTo: iconBackgroundView.topAnchor),

            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            dateLabel.bottomAnchor.constraint(equalTo: iconBackgroundView.bottomAnchor),

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
            trashButton.widthAnchor.constraint(equalToConstant: 16),
            trashButton.heightAnchor.constraint(equalToConstant: 16),
        ])
    }
    
    func configure(with transaction: Transaction) {
        let categoryId = transaction.categoryId.uuidString
            switch categoryId {
            case "f589b847-035c-4bcc-8803-b95fb49ae1af": iconView.image = UIImage(systemName: "cart")
            case "f3bbbca0-495c-48f9-b7ff-9f4c9841cac6": iconView.image = UIImage(systemName: "gift")
            case "b0a5b5f2-ac0c-4e40-b24e-d17410a5e927": iconView.image = UIImage(systemName: "doc.text")
            case "7a7677f1-2a8c-4bd8-9e92-a1cf720f2aab": iconView.image = UIImage(systemName: "house")
            case "e7374de4-2f7a-4207-aa79-712191dc027d": iconView.image = UIImage(systemName: "briefcase")
            default: iconView.image = UIImage(systemName: "questionmark")
        }
        
        titleLabel.text = transaction.title

        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YY"
        dateLabel.text = formatter.string(from: transaction.date)

        let isIncome = transaction.type == "Income"
        amountLabel.text = String(format: "€ %.2f", abs(transaction.value))

        arrowImageView.image = UIImage(systemName: isIncome ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
        arrowImageView.tintColor = isIncome ? Colors.green : Colors.red
        
    }
}
