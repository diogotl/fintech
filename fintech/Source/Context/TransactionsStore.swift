import Foundation
import UIKit

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
            date: ISO8601DateFormatter().date(from: "2025-06-05T00:00:00Z")!
        ),
        Transaction(
            title: "Restaurante",
            category: "Food",
            amount: 80.00,
            type: "Expense",
            date: ISO8601DateFormatter().date(from: "2024-06-03T00:00:00Z")!
        ),
        Transaction(
            title: "Transporte",
            category: "Transport",
            amount: 50.00,
            type: "Expense",
            date: ISO8601DateFormatter().date(from: "2024-06-01T00:00:00Z")!
        ),
    ]

    private var budgetPerMonth: [Budget] = [
        Budget(id: UUID(), month: ISO8601DateFormatter().date(from: "2024-06-01T00:00:00Z")!, limit: 5000.00),
        Budget(id: UUID(), month: ISO8601DateFormatter().date(from: "2024-07-01T00:00:00Z")!, limit: 5500.00),
        Budget(id: UUID(), month: ISO8601DateFormatter().date(from: "2025-08-01T00:00:00Z")!, limit: 6000.00),
    ]

    var onTransactionsChanged: (() -> Void)?
    
    var selectedMonth: Date = Date() 

    func add(_ transaction: Transaction) {
        transactions.append(transaction)
        onTransactionsChanged?()
    }

    var transactionsForSelectedMonth: [Transaction] {
        let calendar = Calendar.current
        return transactions.filter { transaction in
            calendar.isDate(transaction.date, equalTo: selectedMonth, toGranularity: .month)
        }
    }

    var balanceForSelectedMonth: Double {
        transactionsForSelectedMonth.reduce(0) { $0 + $1.amount }
        
        return transactionsForSelectedMonth.reduce(0) { $0 + $1.amount }
    }

}
