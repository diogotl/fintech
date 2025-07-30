//
//  CreateMonthlyBudgetViewModel.swift
//  fintech
//
//  Created by Diogo on 24/07/2025.
//

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
    
    
    func getAllBudgets() -> [Budget] {
        return store.getAllBudgets()
    }
    
    
}

