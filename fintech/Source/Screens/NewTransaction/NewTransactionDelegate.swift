//
//  NewTransactionDelegate.swift
//  fintech
//
//  Created by Diogo on 21/07/2025.
//

import Foundation

protocol NewTransactionDelegate: AnyObject {
    func didTapSaveTransaction(
        title: String,
        categoryId: UUID,
        value: Double,
        date: Date,
        type: String
    )
}
