import Foundation
import UIKit

class HomeView: UIView {

    weak var delegate: HomeViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        summaryCardComponent.delegate = self
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
        addSubview(monthSelectorView)
        addSubview(contentContainerView)
        contentContainerView.addSubview(contentView)
        contentView.addSubview(summaryCardComponent)
        contentView.addSubview(transactionsTableViewHeader)
        transactionsTableViewHeader.addSubview(transactiionsTableViewHeaderLabel)
        transactionsTableViewHeader.addSubview(transactiionsTableViewHeaderCountLabel)
        contentView.addSubview(transactionsTableView)
        transactionsTableView.addSubview(emptyStateLabel)
        addSubview(floatingButton)
        setupGestureRecognizers()
        setupConstraints()
    }

    let monthSelectorView: MonthSelectorView = {
        let view = MonthSelectorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let contentContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()

    private func setupGestureRecognizers() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeLeft))
        swipeLeft.direction = .left
        contentContainerView.addGestureRecognizer(swipeLeft)

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeRight))
        swipeRight.direction = .right
        contentContainerView.addGestureRecognizer(swipeRight)
    }

    @objc
    private func handleSwipeLeft() {
        animateContentTransition(direction: .left) { [weak self] in
            self?.delegate?.didSwipeToNextMonth()
        }
    }

    @objc
    private func handleSwipeRight() {
        animateContentTransition(direction: .right) { [weak self] in
            self?.delegate?.didSwipeToPreviousMonth()
        }
    }

    func animateContentTransition(
        direction: UISwipeGestureRecognizer.Direction, completion: @escaping () -> Void
    ) {
        let screenWidth = bounds.width
        let translateX: CGFloat = direction == .left ? -screenWidth : screenWidth

        // Criar snapshot do conteúdo atual
        guard let snapshot = contentView.snapshotView(afterScreenUpdates: false) else {
            completion()
            return
        }
        snapshot.frame = contentView.frame
        contentContainerView.addSubview(snapshot)

        // Chamar completion para atualizar dados
        completion()

        // Posicionar novo conteúdo fora da tela (após atualização dos dados)
        contentView.transform = CGAffineTransform(translationX: -translateX, y: 0)
        contentView.layoutIfNeeded()

        // Animar transição
        UIView.animate(
            withDuration: 0.35,
            delay: 0,
            usingSpringWithDamping: 0.85,
            initialSpringVelocity: 0.5,
            options: [.curveEaseOut],
            animations: {
                // Slide do conteúdo antigo para fora
                snapshot.transform = CGAffineTransform(translationX: translateX, y: 0)
                snapshot.alpha = 0.7

                // Slide do novo conteúdo para dentro
                self.contentView.transform = .identity
            }
        ) { _ in
            snapshot.removeFromSuperview()
        }
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
        let icon = UIImage(systemName: "arrow.backward.square")
        button.setImage(icon, for: .normal)
        button.tintColor = .black
        button.backgroundColor = .clear
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(signOut), for: .touchUpInside)
        return button
    }()

    @objc
    private func signOut() {
        delegate?.didTapSignOutButton()
    }

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.gray200
        return view
    }()

    private let summaryCard: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.cornerRadius = 12
        return view
    }()

    let summaryCardComponent: SummaryCardComponent = {
        let component = SummaryCardComponent()
        component.configure(
            budget: 0,
            usedExpenses: 0,
            limit: 0,
            month: Date(),
            usedPercentage: 0,
            transactions: [])
        component.translatesAutoresizingMaskIntoConstraints = false
        return component
    }()

    let transactionsTableViewHeader: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()

    let transactiionsTableViewHeaderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Transactions"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black

        return label
    }()

    let transactiionsTableViewHeaderCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.text = "123"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .black
        return label
    }()

    let emptyStateLabel: UILabel = {
        let label = UILabel()
        label.text = "No transactions yet."
        label.textAlignment = .center
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let transactionsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.layer.cornerRadius = 12
        tableView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        tableView.register(TransactionCell.self, forCellReuseIdentifier: "TransactionCell")
        return tableView
    }()

    let floatingButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.tintColor = .white
        let icon = UIImage(systemName: "plus")
        button.setImage(icon, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        button.layer.cornerRadius = 32
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(didTapFloatingButton), for: .touchUpInside)
        return button
    }()

    @objc
    private func didTapFloatingButton() {
        delegate?.didTapPlusButton()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            userData.leadingAnchor.constraint(equalTo: leadingAnchor),
            userData.trailingAnchor.constraint(equalTo: trailingAnchor),
            userData.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            userData.heightAnchor.constraint(equalToConstant: 60),

            userAvatar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            userAvatar.leadingAnchor.constraint(equalTo: userData.leadingAnchor, constant: 16),
            userAvatar.widthAnchor.constraint(equalToConstant: 40),
            userAvatar.heightAnchor.constraint(equalToConstant: 40),

            userName.topAnchor.constraint(equalTo: userAvatar.topAnchor),
            userName.leadingAnchor.constraint(equalTo: userAvatar.trailingAnchor, constant: 16),

            userAppDescription.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 2),
            userAppDescription.leadingAnchor.constraint(equalTo: userName.leadingAnchor),

            logOuttButton.topAnchor.constraint(equalTo: userAvatar.topAnchor),
            logOuttButton.trailingAnchor.constraint(
                equalTo: userData.trailingAnchor, constant: -8),
            logOuttButton.heightAnchor.constraint(equalToConstant: 32),
            logOuttButton.widthAnchor.constraint(equalToConstant: 32),

            monthSelectorView.topAnchor.constraint(equalTo: userData.bottomAnchor, constant: 8),
            monthSelectorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            monthSelectorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            monthSelectorView.heightAnchor.constraint(equalToConstant: 44),

            contentContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentContainerView.topAnchor.constraint(equalTo: monthSelectorView.bottomAnchor),
            contentContainerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

            contentView.leadingAnchor.constraint(equalTo: contentContainerView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: contentContainerView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: contentContainerView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: contentContainerView.bottomAnchor),

            summaryCardComponent.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            summaryCardComponent.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor, constant: 16),
            summaryCardComponent.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor, constant: -16),
            summaryCardComponent.heightAnchor.constraint(equalToConstant: 232),

            transactionsTableViewHeader.topAnchor.constraint(
                equalTo: summaryCardComponent.bottomAnchor, constant: 16),
            transactionsTableViewHeader.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor, constant: 16),
            transactionsTableViewHeader.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor, constant: -16),
            transactionsTableViewHeader.heightAnchor.constraint(equalToConstant: 44),

            transactionsTableViewHeader.leadingAnchor.constraint(
                equalTo: transactionsTableViewHeader.leadingAnchor, constant: 16),
            transactionsTableView.centerXAnchor.constraint(
                equalTo: transactionsTableViewHeader.centerXAnchor),

            transactiionsTableViewHeaderLabel.leadingAnchor.constraint(
                equalTo: transactionsTableViewHeader.leadingAnchor, constant: 16),
            transactiionsTableViewHeaderLabel.centerYAnchor.constraint(
                equalTo: transactionsTableViewHeader.centerYAnchor),
            transactiionsTableViewHeaderCountLabel.trailingAnchor.constraint(
                equalTo: transactionsTableViewHeader.trailingAnchor, constant: -16),
            transactiionsTableViewHeaderCountLabel.centerYAnchor.constraint(
                equalTo: transactionsTableViewHeader.centerYAnchor),

            transactionsTableView.topAnchor.constraint(
                equalTo: transactionsTableViewHeader.bottomAnchor),
            transactionsTableView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor, constant: 16),
            transactionsTableView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor, constant: -16),
            transactionsTableView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor, constant: -16),

            emptyStateLabel.centerXAnchor.constraint(equalTo: transactionsTableView.centerXAnchor),
            emptyStateLabel.centerYAnchor.constraint(equalTo: transactionsTableView.centerYAnchor),

            floatingButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            floatingButton.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8),
            floatingButton.widthAnchor.constraint(equalToConstant: 64),
            floatingButton.heightAnchor.constraint(equalToConstant: 64),
        ])
    }
}

extension HomeView: SummaryCardComponentDelegate {
    func didTapSummaryCardSettingsButton() {
        delegate?.didTapSettingsButton()
    }
}
