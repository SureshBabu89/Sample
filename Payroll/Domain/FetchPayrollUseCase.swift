//
//  File.swift
//  Payroll
//
//  Created by Suresh Babu Rajendran on 03/07/26.
//

import Foundation
protocol FetchPayrollUseCase {
    func execute() async throws -> [Payroll]
}

final class FetchPayrollUseCaseImpl: FetchPayrollUseCase {

    private let repository: PayrollRepository

    init(repository: PayrollRepository) {
        self.repository = repository
    }

    func execute() async throws -> [Payroll]{
        try await repository.fetchPayrolls()
    }
}
