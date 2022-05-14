//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Maxime on 14/05/2022.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
