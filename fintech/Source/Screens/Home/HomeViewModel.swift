import Foundation

class HomeViewModel {
    private let store: TransactionsStore
    private let calendar = Calendar.current

    init(store: TransactionsStore) {
        self.store = store
        store.onDataChanged = { [weak self] in
            self?.onUpdate?()
        }
    }

    var onUpdate: (() -> Void)?

    // MARK: - Month Management

    var availableMonths: [Date] {
        let currentYear = calendar.component(.year, from: Date())
        var months: [Date] = []
        for month in 1...12 {
            if let date = calendar.date(
                from: DateComponents(year: currentYear, month: month, day: 1))
            {
                months.append(date)
            }
        }
        return months
    }

    var currentSelectedMonth: Date {
        return store.selectedMonth
    }

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

    func goToNextMonth() {
        let nextMonth =
            calendar.date(byAdding: .month, value: 1, to: currentSelectedMonth)
            ?? currentSelectedMonth
        changeMonth(to: nextMonth)
    }

    func goToPreviousMonth() {
        let previousMonth =
            calendar.date(byAdding: .month, value: -1, to: currentSelectedMonth)
            ?? currentSelectedMonth
        changeMonth(to: previousMonth)
    }
}
