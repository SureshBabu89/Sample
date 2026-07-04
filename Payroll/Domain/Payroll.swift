//
//  Payroll.swift
//  Payroll
//
//  Created by Suresh Babu Rajendran on 04/07/26.
//

import Foundation
struct Payroll : Identifiable{
    var id: UUID
    var createdDate: Date
    var employees: [Employee]

    var totalAmount: Double {
        employees.reduce(0) { $0 + $1.wages }
    }

    var totalTaxes: Double {
        employees.reduce(0) { $0 + $1.taxes }
    }

    var totalNet: Double {
        employees.reduce(0) { $0 + $1.net }
    }
}
