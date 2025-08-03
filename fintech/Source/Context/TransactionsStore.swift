import CoreData
import Foundation

struct MonthlySummary {
    let transactions: [Transaction]
    let balance: Double
    let usedAmount: Double
    let usedPercentage: Double
    let limit: Double
}

class TransactionsStore {
    private let context = CoreDataHelper.shared.context

    private(set) var transactions: [Transaction] = [

        ]

    private(set) var budgetPerMonth: [Budget] = [
        Budget(
            id: UUID(),
            date: ISO8601DateFormatter().date(from: "2025-07-01T00:00:00Z")!,
            limit: 50000)
    ]

    var selectedMonth: Date = Date()

    var onDataChanged: (() -> Void)?

    func addTransaction(_ transaction: Transaction) {
        transactions.append(transaction)
        onDataChanged?()
    }

    func createTransaction(title: String, value: Int32, date: Date, type: String) {
        let transaction = NSEntityDescription.insertNewObject(
            forEntityName: "Transaction", into: context)
        transaction.setValue(title, forKey: "title")
        transaction.setValue(value, forKey: "value")
        transaction.setValue(date, forKey: "date")
        transaction.setValue(type, forKey: "type")
        CoreDataHelper.shared.saveContext()
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

        guard let budget = fetchBudgetsFromCoreData().first(where: {
                calendar.component(.month, from: $0.date) == selectedMonthValue
            })
        else { return nil }

        let usedAmount =
            transactionsOfMonth
            .filter { $0.type.lowercased() == "expense" }
            .reduce(0) { $0 + $1.value }

        let totalIncome =
            transactionsOfMonth
            .filter { $0.type.lowercased() == "income" }
            .reduce(0) { $0 + $1.value }

        let balance = totalIncome - usedAmount
        let usedPercentage = budget.limit == 0 ? 0 : (usedAmount / budget.limit) * 100

        return MonthlySummary(
            transactions: transactionsOfMonth,
            balance: Double(balance) / 100.0,
            usedAmount: Double(usedAmount) / 100.0,
            usedPercentage: Double(usedPercentage),
            limit: Double(budget.limit) / 100.0
        )
    }

    func getAllBudgets() -> [Budget] {
        return fetchBudgetsFromCoreData()
    }

    func saveBudgetToCoreData(_ budget: Budget) {
        let budgetEntity = NSEntityDescription.insertNewObject(
            forEntityName: "BudgetEntity", into: context)
        budgetEntity.setValue(budget.id, forKey: "id")
        budgetEntity.setValue(budget.date, forKey: "date")
        budgetEntity.setValue(budget.limit, forKey: "limit")
        CoreDataHelper.shared.saveContext()
        onDataChanged?()
    }

    func fetchBudgetsFromCoreData() -> [Budget] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "BudgetEntity")
        do {
            let results = try context.fetch(fetchRequest)
            return results.compactMap { obj in
                guard
                    let id = obj.value(forKey: "id") as? UUID,
                    let date = obj.value(forKey: "date") as? Date,
                    let limit = obj.value(forKey: "limit") as? Int32
                        
                else {
                    return nil
                }
                return Budget(id: id, date: date, limit: limit)
            }
            onDataChanged?()
            
        } catch {
            print("Erro ao buscar budgets: \(error)")
            return []
        }
        
    }


    func changeMonth(to date: Date) {
        selectedMonth = date
        onDataChanged?()
    }
}
