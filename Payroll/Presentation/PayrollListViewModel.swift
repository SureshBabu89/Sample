//
//  PayrollListViewModel.swift
//  Payroll
//
//  Created by Suresh Babu Rajendran on 03/07/26.
//

import Foundation
@MainActor
@Observable
final class PayrollListViewModel {

    var payrolls: [Payroll] = []

    private let fetchPayrollUseCase: FetchPayrollUseCase

    init(fetchPayrollUseCase: FetchPayrollUseCase) {
        self.fetchPayrollUseCase = fetchPayrollUseCase
    }

    func fetchPayroll() async throws {
       payrolls = try await fetchPayrollUseCase.execute()
    }
}
