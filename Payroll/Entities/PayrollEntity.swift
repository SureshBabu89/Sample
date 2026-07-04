//
//  Payroll.swift
//  Payroll
//
//  Created by Suresh Babu Rajendran on 03/07/26.
//

import Foundation
import SwiftData

@Model
final class PayrollEntity {

    @Attribute(.unique)
    var id: UUID

    var createdDate: Date

    @Relationship(deleteRule: .cascade)
    var employees: [EmployeeEntity]

    init(
        id: UUID = UUID(),
        createdDate: Date = .now,
        employees: [EmployeeEntity]
    ) {
        self.id = id
        self.createdDate = createdDate
        self.employees = employees
    }
}

