class HomeViewModel {
    public var transactions: [Transaction] = [
        Transaction(
            description: "Supermercado",
            price: -150.00,
            category: "Food",
            type: "Expense",
            date: "2024-06-10"
        ),
        Transaction(
            description: "Salário",
            price: 3000.00,
            category: "Income",
            type: "Income",
            date: "2024-06-05"
        ),
        Transaction(
            description: "Restaurante",
            price: -80.00,
            category: "Food",
            type: "Expense",
            date: "2024-06-03"
        ),
        Transaction(
            description: "Transporte",
            price: -50.00,
            category: "Transport",
            type: "Expense",
            date: "2024-06-01"
        ),
    ]
}
