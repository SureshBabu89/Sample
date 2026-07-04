//
//  CreatePayrollViewModel.swift
//  Payroll
//
//  Created by Suresh Babu Rajendran on 03/07/26.
//

import Foundation
@MainActor
@Observable
final class CreatePayrollViewModel {

    var name: String = ""
    var wages: Double = 0
    var exempt = false

    var employees: [Employee] = []

    private let createPayrollUseCase: CreatePayrollUseCase

    init(createPayrollUseCase: CreatePayrollUseCase) {
        self.createPayrollUseCase = createPayrollUseCase
    }

      var payrollNameError: String?
      var employeeCountError: String?

      func validate() -> Bool {
          payrollNameError = nil
          employeeCountError = nil

          var isValid = true

          if name.trimmingCharacters(in: .whitespaces).isEmpty {
              payrollNameError = "Employee name is required."
              isValid = false
          }

          if wages == 0 {
              employeeCountError = "Employee count is required."
              isValid = false
          } else if Double(wages) == nil {
              employeeCountError = "Enter a valid number."
              isValid = false
          }

          return isValid
      }

    func addEmployee() {

        guard validate() else { return }

        let employee = Employee(
            id: UUID(),
            name: name,
            wages: wages,
            isExempt: exempt
        )

        employees.append(employee)

        name = ""
        wages = 0
        exempt = false
    }

    func savePayroll() async throws {

        let payroll = Payroll(
            id: UUID(),
            createdDate: .now,
            employees: employees
        )

        try await createPayrollUseCase.execute(payroll)
    }

}
