import Foundation
import UIKit

class HomeViewController: UIViewController {

    var contentView: HomeView
    var viewModel: HomeViewModel
    var flowDelegate: HomeViewFlowDelegate?

    init(
        contentView: HomeView,
        viewModel: HomeViewModel,
        flowDelegate: HomeViewFlowDelegate?
    ) {
        self.contentView = contentView
        self.viewModel = viewModel
        self.flowDelegate = flowDelegate
        super.init(nibName: nil, bundle: nil)
        setup()
        contentView.transactionsTableView.dataSource = self
        contentView.transactionsTableView.delegate = self

        viewModel.onUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.contentView.transactiionsTableViewHeaderCountLabel.text =
                    "\(viewModel.transactionsCount)"

                self?.contentView.emptyStateLabel.isHidden = viewModel.transactionsCount > 0
                self?.contentView.transactionsTableView.reloadData()
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

    func getMonthNumber(from date: Date) -> Int? {
        return Calendar.current.dateComponents([.month], from: date).month
    }

    func didSelectMonth(_ month: Date) {
        viewModel.changeMonth(to: month)

        let summary = viewModel.summary

        contentView.summaryCardComponent.configure(
            budget: summary?.balance ?? 0,
            usedExpenses: summary?.usedAmount ?? 0,
            limit: summary?.limit ?? 0,
            month: month,
            usedPercentage: summary?.usedPercentage ?? 0,
            transactions: summary?.transactions ?? []
        )
    }

    func isMonthSelected(_ month: Date) -> Bool {
        //idk
        return true
    }
}
