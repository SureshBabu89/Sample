//
//  PayrollApp.swift
//  Payroll
//
//  Created by Suresh Babu Rajendran on 03/07/26.
//

import SwiftUI
import SwiftData

@main
struct PayrollApp: App {
    var body: some Scene {

        WindowGroup {
            RootView()
        }
        .modelContainer(for: [
            PayrollEntity.self,
            EmployeeEntity.self
        ])
    }
}

struct RootView: View {

    @Environment(\.modelContext)
    private var context

    var body: some View {

        let container = DependencyContainer(
            context: context
        )

        PayrollListView(
            viewModel:
                container.makePayrollListViewModel()
        )
    }
}

@MainActor
final class DependencyContainer {

    let context: ModelContext

    lazy var repository =
        PayrollRepositoryImpl(context: context)

    init(context: ModelContext) {

        self.context = context
    }

    func makePayrollListViewModel()
    -> PayrollListViewModel {

        let fetchPayrollUseCase =
             FetchPayrollUseCaseImpl(repository: repository)

        return PayrollListViewModel(fetchPayrollUseCase: fetchPayrollUseCase)
    }

    func makeCreatePayrollViewModel()
    -> CreatePayrollViewModel {

        let createPayrollUseCase =
              CreatePayrollUseCaseImpl(repository: repository)

        return CreatePayrollViewModel(createPayrollUseCase: createPayrollUseCase)

    }
}
