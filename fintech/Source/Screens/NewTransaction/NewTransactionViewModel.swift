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
    
    func add(transaction: Transaction) {
        store.add(transaction)
    }
}
