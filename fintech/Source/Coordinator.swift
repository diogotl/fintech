import Foundation
import UIKit

class Coordinator {

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
        let viewModel = HomeViewModel(store: transactionStore)
        let startViewController = HomeViewController(
            contentView: contentView,
            viewModel: viewModel,
            flowDelegate: self
        )
        
        // Hide the back button for this view controller
        startViewController.navigationItem.hidesBackButton = true

        navigationController?.pushViewController(
            startViewController,
            animated: true
        )
        // Optionally disable the swipe-to-go-back gesture
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
}

extension Coordinator: HomeViewFlowDelegate {
    func returnToSignUp() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func goToCreateMonthlyBudget() {
        let store = TransactionsStore()
        let createMonthlyBudgetViewModel = CreateMonthlyBudgetViewModel(
            store: store,
        )
        let createMonthlyBudgetView = CreateMonthlyBudgetView()
        let createMonthlyBudgetController = CreateMonthlyBudgetController(
            contentView: createMonthlyBudgetView,
            viewModel: createMonthlyBudgetViewModel,
            flowDelegate: self
        )
        
        createMonthlyBudgetController.navigationItem.hidesBackButton = true

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

extension Coordinator: CreateMonthlyBudgetFlowDelegate {
    func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
}
 
