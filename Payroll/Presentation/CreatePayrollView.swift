//
//  CreatePayrollView.swift
//  Payroll
//
//  Created by Suresh Babu Rajendran on 03/07/26.
//

import Foundation
import SwiftUI
import SwiftData

struct CreatePayrollView: View {

    @Environment(\.dismiss) private var dismiss

    @State private var viewModel: CreatePayrollViewModel

    init(viewModel: CreatePayrollViewModel) {
           _viewModel = State(initialValue: viewModel)
     }

    var body: some View {
        
        NavigationStack {
            
            Form {
                
                Section("Employee") {
                    
                    VStack(alignment: .leading, spacing: 4) {
                        
                        TextField("Name",
                                  text: $viewModel.name)
                        
                        ValidationText(message: viewModel.payrollNameError)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        
                        TextField(
                            "Wages",
                            value: $viewModel.wages,
                            format: .number
                        )
                        .keyboardType(.decimalPad)
                        
                        ValidationText(message: viewModel.employeeCountError)
                    }
                    
                    Toggle(
                        "Tax Exempt",
                        isOn: $viewModel.exempt
                    )
                    
                    Button("Add Employee") {
                        
                        viewModel.addEmployee()
                    }
                }
                
                Section("Employees") {
                    
                    ForEach(viewModel.employees) { employee in
                        
                        HStack {
                            
                            VStack(alignment: .leading) {
                                
                                Text(employee.name)
                                
                                Text("$\(employee.wages, specifier: "%.2f")")
                                    .foregroundStyle(.secondary)
                            }
                            
                            Spacer()
                            
                            Button("Remove") {
                                
                                //viewModel.remove(employee)
                            }
                            .foregroundStyle(.red)
                        }
                    }
                }
            }
            .navigationTitle("Create Payroll")
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    
                    Button("Cancel") {
                        
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    
                    Button("Save") {
                        Task  {
                            do {
                                try await viewModel.savePayroll()
                                
                            } catch let error{
                                print(error)
                            }
                        }
                        
                        dismiss()
                    }
                    .disabled(viewModel.employees.isEmpty)
                }
            }
        }
    }
}

struct ValidationText: View {

    let message: String?

    var body: some View {
        if let message {
            Text(message)
                .font(.caption)
                .foregroundStyle(.red)
        }
    }
}
