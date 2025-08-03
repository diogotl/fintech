//
//  Budget.swift
//  fintech
//
//  Created by Diogo on 21/07/2025.
//

import UIKit
import Foundation

struct Budget : Identifiable {
    public let id: UUID
    let date: Date
    let limit: Int32
}
