//
//  ContentView.swift
//  Payroll
//
//  Created by Suresh Babu Rajendran on 03/07/26.
//

import SwiftUI
import SwiftData

struct PayrollListView: View {
    
    @Environment(\.modelContext)
    private var context
    
    @State private var viewModel: PayrollListViewModel
    
    init(viewModel: PayrollListViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    
    var body: some View {
        
        NavigationStack {
            Group{
                if viewModel.payrollCount == 0 {
                    // Asset image
                    ContentUnavailableView(
                        "No Payroll",
                        systemImage: "tray",
                        description: Text("Add your first Payroll.")
                    )
                }else {
                    List(viewModel.payrolls) { payroll in
                        
                        NavigationLink {
                            
                            PayrollDetailView(
                                payroll: payroll
                            )
                            
                        } label: {
                            PayrollRowView(payroll: payroll)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .task {
                do {
                    try await MainActor.run {
                        try context.save()
                    }
                    try await viewModel.fetchPayroll()
                }catch{
                    
                }
                
            }
            .navigationTitle("Payrolls")
            .toolbar {
                
                NavigationLink {
                    
                    let container = DependencyContainer(
                        context: context
                    )
                    
                    CreatePayrollView(viewModel: container.makeCreatePayrollViewModel())
                    
                } label: {
                    
                    Image(systemName: "plus")
                }
            }
            
        }
        
    }
}

struct PayrollRowView: View {
    
    let payroll: Payroll
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            
            Text(payroll.createdDate.formatted())
            
                .font(.headline)
            
            Text("Employees: \(payroll.employees.count)")
            
            Text("Total: $\(payroll.totalAmount, specifier: "%.2f")")
                .bold()
        }
        .padding(.vertical, 8)
        .task {
            
        }
    }
}

//#Preview {
//    PayrollListView()
//}
