import Foundation

class HomeViewModel {
    private let store: TransactionsStore

    init(store: TransactionsStore) {
        self.store = store
        store.onDataChanged = { [weak self] in
            self?.onUpdate?()
        }
    }

    var onUpdate: (() -> Void)?

    var summary: MonthlySummary? {
        return store.getMonthlySummary()
    }

    var transactions: [Transaction] {
        return summary?.transactions ?? []
    }

    var transactionsCount: Int {
        return transactions.count
    }

    var emptyStateText: String {
        return transactionsCount == 0 ? "No transactions yet" : ""
    }

    var balance: Double {
        return summary?.balance ?? 0
    }

    var usedAmount: Double {
        return summary?.usedAmount ?? 0
    }

    var usedPercentage: Double {
        return summary?.usedPercentage ?? 0
    }

    var budgetLimit: Double {
        return summary?.limit ?? 0
    }

    func addTransaction(_ transaction: Transaction) {
        store.addTransaction(transaction)
    }

    func deleteTransaction(at index: Int) {
        store.deleteTransaction(at: index)
    }

    func changeMonth(to date: Date) {
        store.changeMonth(to: date)
    }
}
