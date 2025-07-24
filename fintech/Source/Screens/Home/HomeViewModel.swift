import Foundation

class HomeViewModel {
    let store: TransactionsStore

    init(store: TransactionsStore) {
        self.store = store
    }

    var transactions: [Transaction] {
        return store.transactions
    }

    func addTransaction(_ transaction: Transaction) {
        store.add(transaction)
    }

    var balanceForSelectedMonth: Double {
        return store.balanceForSelectedMonth
    }
}
