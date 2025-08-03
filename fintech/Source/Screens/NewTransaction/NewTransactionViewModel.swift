//
//  NewTransactionViewModel.swift
//  fintech
//
//  Created by Diogo on 21/07/2025.
//

import Foundation

class NewTransactionViewModel {
    
    var store: TransactionsStore
    
    init(store: TransactionsStore) {
        self.store = store
    }
    
    func add(
        title: String,
        categoryId : UUID,
        value: Double,
        date: Date,
        type: String
    ) {
        
        let transaction = Transaction(
            id: UUID(),
            title: title,
            value: Int32(value * 100),
            type: type,
            date: date,
            categoryId: categoryId,
        )
        
        self.store.addTransaction(
            transaction
        )
    }
}
