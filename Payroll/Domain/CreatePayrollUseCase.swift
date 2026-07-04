//
//  CreatePayrollUseCase.swift
//  Payroll
//
//  Created by Suresh Babu Rajendran on 03/07/26.
//

import Foundation
protocol CreatePayrollUseCase {
    func execute(_ payroll: Payroll) async throws
}

final class CreatePayrollUseCaseImpl: CreatePayrollUseCase {

    private let repository: PayrollRepository

    init(repository: PayrollRepository) {
        self.repository = repository
    }

    func execute(_ payroll: Payroll) async throws {
        try await repository.save(payroll)
    }
}


protocol PayrollRepository {

    func save(_ payroll: Payroll) async throws

    func fetchPayrolls() async throws -> [Payroll]
}
