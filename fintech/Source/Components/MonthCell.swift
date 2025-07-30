import Foundation
import UIKit

protocol MonthCellDelegate: AnyObject {
    func didSelectMonth(_ date: Date)
}

class MonthCell: UICollectionViewCell {
    static let reuseIdentifier = "MonthCell"

    private let monthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        return label
    }()

    private let underlineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()

    }

    private func setupUI() {
        contentView.addSubview(monthLabel)
        contentView.addSubview(underlineView)
        setupConstrains()
    }

    private func setupConstrains() {
        NSLayoutConstraint.activate([
            monthLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            monthLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            monthLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            monthLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            underlineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            underlineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            underlineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            underlineView.heightAnchor.constraint(equalToConstant: 6),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with date: Date, selected: Bool) {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pt_PT")
        formatter.dateFormat = "MMM"
        monthLabel.text = formatter.string(from: date).capitalized
        underlineView.backgroundColor = selected ? Colors.magenta : .clear
    }
}
