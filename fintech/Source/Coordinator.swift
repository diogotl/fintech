import Foundation
import UIKit

class Coordinator {

    private var navigationController: UINavigationController?
    let transactionStore = TransactionsStore()

    func start() -> UINavigationController? {
        let contentView = HomeView()
        //let transactionStore = TransactionsStore()
        let viewModel = HomeViewModel(
            store: transactionStore
        )
        let startViewController = HomeViewController(
            contentView: contentView,
            viewModel: viewModel,
            flowDelegate: self
        )
        self.navigationController = UINavigationController(rootViewController: startViewController)
        return navigationController
    }
}

extension Coordinator: HomeViewFlowDelegate {
    func openNewTransactionBottomSheet() {
        let newTransactionView = NewTransaction()
        let newTransactionViewModel = NewTransactionViewModel(
            store: transactionStore
        )
        let controller = NewTransactionController(
            contentView: newTransactionView,
            viewModel: newTransactionViewModel
        )
        controller.modalPresentationStyle = .pageSheet
        controller.modalTransitionStyle = .coverVertical
        navigationController?.present(controller, animated: true, completion: nil)
        
    }
}
