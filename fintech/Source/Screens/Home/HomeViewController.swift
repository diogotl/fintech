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

        viewModel.store.onTransactionsChanged = { [weak self] in
            DispatchQueue.main.async {
                self?.contentView.transactionsTableView.reloadData()
            }
        }

        print(viewModel.balanceForSelectedMonth)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        view.addSubview(contentView)
        contentView.delegate = self

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
        return 120
    }
}

extension HomeViewController: HomeViewDelegate {
    func didTapPlusButton() {
        flowDelegate?.openNewTransactionBottomSheet()
    }
}
