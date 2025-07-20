import Foundation
import UIKit

class HomeView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        backgroundColor = .white
        addSubview(userData)
        userData.addSubview(userAvatar)
        userData.addSubview(userName)
        userData.addSubview(userAppDescription)
        userData.addSubview(logOuttButton)
        addSubview(contentView)
        contentView.addSubview(summaryCardComponent)
        contentView.addSubview(transactionsTableView)
        setupConstraints()
    }

    private let userData: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let userAvatar: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .black
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()

    private let userName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "User Name"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()

    private let userAppDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "This is a description of the app or user."
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    private let logOuttButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("X", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 8
        return button
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()

    private let summaryCard: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.cornerRadius = 12
        return view
    }()

    private let summaryCardComponent: SummaryCardComponent = {
        let component = SummaryCardComponent(
            balance: "$1,000.00",
            change: "+$100.00",
            period: "Last 30 days",
        )
        component.translatesAutoresizingMaskIntoConstraints = false
        return component
    }()

    let transactionsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.register(TransactionCell.self, forCellReuseIdentifier: "TransactionCell")
        return tableView
    }()

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            userData.leadingAnchor.constraint(equalTo: leadingAnchor),
            userData.trailingAnchor.constraint(equalTo: trailingAnchor),
            userData.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            userData.heightAnchor.constraint(equalToConstant: 100),

            userAvatar.topAnchor.constraint(equalTo: userData.topAnchor, constant: 20),
            userAvatar.leadingAnchor.constraint(equalTo: userData.leadingAnchor, constant: 16),
            userAvatar.widthAnchor.constraint(equalToConstant: 40),
            userAvatar.heightAnchor.constraint(equalToConstant: 40),

            userName.topAnchor.constraint(equalTo: userAvatar.topAnchor),
            userName.leadingAnchor.constraint(equalTo: userAvatar.trailingAnchor, constant: 16),

            userAppDescription.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 2),
            userAppDescription.leadingAnchor.constraint(equalTo: userName.leadingAnchor),

            logOuttButton.topAnchor.constraint(equalTo: userAvatar.topAnchor),
            logOuttButton.trailingAnchor.constraint(
                equalTo: userData.trailingAnchor, constant: -16),
            logOuttButton.heightAnchor.constraint(equalToConstant: 44),
            logOuttButton.widthAnchor.constraint(equalToConstant: 44),

            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: userData.bottomAnchor),
            contentView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

            summaryCardComponent.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 60),
            summaryCardComponent.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor, constant: 16),
            summaryCardComponent.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor, constant: -16),
            summaryCardComponent.heightAnchor.constraint(equalToConstant: 232),

            transactionsTableView.topAnchor.constraint(
                equalTo: summaryCardComponent.bottomAnchor, constant: 16),
            transactionsTableView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor, constant: 16),
            transactionsTableView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor, constant: -16),
            transactionsTableView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor, constant: -16),
        ])
    }
}
