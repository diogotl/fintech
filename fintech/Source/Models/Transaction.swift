//
//  Transaction.swift
//  fintech
//
//  Created by Diogo on 19/07/2025.
//

import Foundation

public struct Transaction : Identifiable {
    public let id: UUID
    
    let title: String
    let value: Int32
    let type: String
    let date: Date
    
    let categoryId: UUID
}
