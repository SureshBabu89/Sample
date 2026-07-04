//
//  Employee.swift
//  Payroll
//
//  Created by Suresh Babu Rajendran on 03/07/26.
//
import Foundation
import SwiftData



@Model
final class EmployeeEntity {

    @Attribute(.unique)
    var id: UUID

    var name: String

    var wages: Double

    var exempt: Bool

    init(
        id: UUID = UUID(),
        name: String,
        wages: Double,
        exempt: Bool
    ) {
        self.id = id
        self.name = name
        self.wages = wages
        self.exempt = exempt
    }
}

