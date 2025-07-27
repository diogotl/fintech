import Foundation
import UIKit

class Coordinator: CreateMonthlyBudgetFlowDelegate {

    private var navigationController: UINavigationController?
    let transactionStore = TransactionsStore()

    func start() -> UINavigationController? {
        let contentView = SignUpView()
        let viewModel = SignUpViewModel()
        let signUpViewController = SignUpViewController(
            contentView: contentView,
            viewModel: viewModel,
            flowDelegate: self
        )

        self.navigationController = UINavigationController(rootViewController: signUpViewController)
        return navigationController
    }
}

extension Coordinator: SignUpViewFlowDelegate {
    func goToHomeView() {
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

        navigationController?.navigationBar.backItem?.hidesBackButton = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        navigationController?.pushViewController(
            startViewController,
            animated: true,
        )
        
    }
}

extension Coordinator: HomeViewFlowDelegate {
    func goToCreateMonthlyBudget() {
        let createMonthlyBudgetView = CreateMonthlyBudgetView()
        let createMonthlyBudgetController = CreateMonthlyBudgetController(
            contentView: createMonthlyBudgetView,
            flowDelegate: self
        )

        navigationController?.pushViewController(
            createMonthlyBudgetController,
            animated: true
        )
    }

    func openNewTransactionBottomSheet() {
        let newTransactionView = NewTransaction()
        let newTransactionViewModel = NewTransactionViewModel(
            store: transactionStore
        )

        let controller = NewTransactionController(
            contentView: newTransactionView,
            viewModel: newTransactionViewModel,
        )

        controller.modalPresentationStyle = .pageSheet
        controller.modalTransitionStyle = .coverVertical
        navigationController?.present(controller, animated: true, completion: nil)

    }
}
