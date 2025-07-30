import Foundation

struct MonthlySummary {
    let transactions: [Transaction]
    let balance: Double
    let usedAmount: Double
    let usedPercentage: Double
    let limit: Double
}

class TransactionsStore {
    private(set) var transactions: [Transaction] = [
        Transaction(
            title: "Supermercado",
            category: "Food",
            amount: 150.00,
            type: "Expense",
            date: ISO8601DateFormatter().date(from: "2025-07-10T00:00:00Z")!
        ),
        Transaction(
            title: "Salário",
            category: "Income",
            amount: 3000.00,
            type: "Income",
            date: ISO8601DateFormatter().date(from: "2025-07-05T00:00:00Z")!
        )
    ]

    private(set) var budgetPerMonth: [Budget] = [
        Budget(
            id: UUID(), month: ISO8601DateFormatter().date(from: "2025-07-01T00:00:00Z")!,
            limit: 5000.00)
    ]

    var selectedMonth: Date = Date()

    var onDataChanged: (() -> Void)?

    func addTransaction(_ transaction: Transaction) {
        transactions.append(transaction)
        onDataChanged?()
    }

    func deleteTransaction(at index: Int) {
        guard index < transactions.count else { return }
        transactions.remove(at: index)
        onDataChanged?()
    }

    func getMonthlySummary() -> MonthlySummary? {
        let calendar = Calendar.current
        let selectedMonthValue = calendar.component(.month, from: selectedMonth)

        let transactionsOfMonth = transactions.filter {
            calendar.component(.month, from: $0.date) == selectedMonthValue
        }

        guard let budget = budgetPerMonth.first(where: {
            calendar.component(.month, from: $0.month) == selectedMonthValue
        }) else { return nil }

        let usedAmount = transactionsOfMonth
            .filter { $0.type.lowercased() == "expense" }
            .reduce(0) { $0 + $1.amount }

        let totalIncome = transactionsOfMonth
            .filter { $0.type.lowercased() == "income" }
            .reduce(0) { $0 + $1.amount }

        let balance = totalIncome - usedAmount
        let usedPercentage = budget.limit == 0 ? 0 : (usedAmount / budget.limit) * 100

        return MonthlySummary(
            transactions: transactionsOfMonth,
            balance: balance,
            usedAmount: usedAmount,
            usedPercentage: usedPercentage,
            limit: budget.limit
        )
    }
    
    func getAllBudgets() -> [Budget] {
        return budgetPerMonth
    }

    func changeMonth(to date: Date) {
        selectedMonth = date
        onDataChanged?()
    }
}
