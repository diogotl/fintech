//
//  NewTransactionDelegate.swift
//  fintech
//
//  Created by Diogo on 21/07/2025.
//

protocol NewTransactionDelegate: AnyObject {
    func didTapSaveTransaction(transaction: Transaction)
}
