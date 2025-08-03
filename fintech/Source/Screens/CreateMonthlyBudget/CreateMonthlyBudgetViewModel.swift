//
//  CreateMonthlyBudgetViewModel.swift
//  fintech
//
//  Created by Diogo on 24/07/2025.
//

import Foundation

class CreateMonthlyBudgetViewModel {
    
    let store: TransactionsStore
    
    let months = [
        "January", "February", "March", "April", "May", "June",
        "July", "August", "September", "October", "November", "December"
    ]
    
    let years: [Int] = Array(2020...2030)
    
    init(
        store: TransactionsStore
    ){
        self.store = store
    }
    
    func addBudget(
        monthYear: String,
        budget: Int32
    ) {
        
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM yyyy"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            guard let monthDate = dateFormatter.date(from: monthYear) else {
                print("Invalid monthYear format")
                return
            }

            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month], from: monthDate)
            let firstOfMonth = calendar.date(from: components)!

            let budget = Budget(
                id: UUID(),
                date: firstOfMonth,
                limit: budget * 100
            )

            store.saveBudgetToCoreData(
                budget
            )
    }
        

    
    func getAllBudgets() -> [Budget] {
        return store.getAllBudgets()
    }
}
