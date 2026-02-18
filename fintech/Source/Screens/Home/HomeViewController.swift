import Foundation
import UIKit

class HomeViewController: UIViewController {

    var contentView: HomeView
    var viewModel: HomeViewModel
    var flowDelegate: HomeViewFlowDelegate?
    private var isMonthSelectorConfigured = false

    init(
        contentView: HomeView,
        viewModel: HomeViewModel,
        flowDelegate: HomeViewFlowDelegate?
    ) {
        self.contentView = contentView
        self.viewModel = viewModel
        self.flowDelegate = flowDelegate
        super.init(nibName: nil, bundle: nil)
        contentView.transactionsTableView.dataSource = self
        contentView.transactionsTableView.delegate = self
        setupBindings()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        view.addSubview(contentView)
        contentView.delegate = self
        contentView.monthSelectorView.delegate = self

        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Configurar carrossel apenas uma vez, depois que layout está pronto
        if !isMonthSelectorConfigured {
            configureMonthSelector()
            isMonthSelectorConfigured = true
        }
    }

    private func setupBindings() {
        viewModel.onUpdate = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.updateView()
            }
        }
    }

    private func configureMonthSelector() {
        let months = viewModel.availableMonths
        let currentMonth = viewModel.currentSelectedMonth
        contentView.monthSelectorView.configure(with: months, selectedMonth: currentMonth)

        // Atualizar view com o mês inicial
        updateView()
    }

    private func updateView() {
        let summary = viewModel.summary

        contentView.transactiionsTableViewHeaderCountLabel.text = "\(viewModel.transactionsCount)"
        contentView.emptyStateLabel.isHidden = viewModel.transactionsCount > 0

        contentView.summaryCardComponent.configure(
            budget: summary?.balance ?? 0,
            usedExpenses: summary?.usedAmount ?? 0,
            limit: summary?.limit ?? 0,
            month: viewModel.currentSelectedMonth,
            usedPercentage: summary?.usedPercentage ?? 0,
            transactions: summary?.transactions ?? []
        )

        contentView.transactionsTableView.reloadData()
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.transactions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =
            tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath)
            as! TransactionCell
        cell.configure(with: viewModel.transactions[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension HomeViewController: HomeViewDelegate {
    func didTapSignOutButton() {
        flowDelegate?.returnToSignUp()
    }

    func didTapSettingsButton() {
        flowDelegate?.goToCreateMonthlyBudget()
    }

    func didTapPlusButton() {
        flowDelegate?.openNewTransactionBottomSheet()
    }

    func didSwipeToNextMonth() {
        viewModel.goToNextMonth()
        contentView.monthSelectorView.selectMonth(viewModel.currentSelectedMonth, animated: true)
        updateView()
    }

    func didSwipeToPreviousMonth() {
        viewModel.goToPreviousMonth()
        contentView.monthSelectorView.selectMonth(viewModel.currentSelectedMonth, animated: true)
        updateView()
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
            [weak self] _, _, completionHandler in
            guard let self = self else { return }
            let alert = UIAlertController(
                title: "Confirm Delete",
                message: "Are you sure you want to delete this transaction?",
                preferredStyle: .alert
            )
            alert.addAction(
                UIAlertAction(title: "Cancel", style: .cancel) { _ in
                    completionHandler(false)
                })
            alert.addAction(
                UIAlertAction(title: "Delete", style: .destructive) { _ in
                    self.viewModel.deleteTransaction(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                    completionHandler(true)
                })
            self.present(alert, animated: true, completion: nil)
        }
        deleteAction.image = UIImage(systemName: "trash")
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
}

extension HomeViewController: MonthSelectorViewDelegate {
    func didSelectMonth(_ month: Date) {
        viewModel.changeMonth(to: month)
        updateView()
    }

    func isMonthSelected(_ month: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(
            month, equalTo: viewModel.currentSelectedMonth, toGranularity: .month)
    }
}
