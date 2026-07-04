//
//  Payroll.swift
//  Payroll
//
//  Created by Suresh Babu Rajendran on 03/07/26.
//

import Foundation
import SwiftData

final class PayrollRepositoryImpl: PayrollRepository {

    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func save(_ payroll: Payroll) async throws {

        let employees = payroll.employees.map {

            EmployeeEntity(
                name: $0.name,
                wages: $0.wages,
                exempt: $0.isExempt
            )
        }

        let payroll = PayrollEntity(id: payroll.id, employees: employees)

        context.insert(payroll)

        do {
            try context.save()
        }catch let error {
           print(error)
        }


    }

    func fetchPayrolls() throws -> [Payroll] {

        let descriptor = FetchDescriptor<PayrollEntity>()

        let entities = try context.fetch(descriptor)

        return entities.map {

            Payroll(
                id: $0.id,
                createdDate: $0.createdDate,
                employees: $0.employees.map {

                    Employee(
                        id: $0.id,
                        name: $0.name,
                        wages: $0.wages,
                        isExempt: $0.exempt
                    )
                }
            )
        }

    }
}
