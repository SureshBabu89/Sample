//
//  PayrollDetail.swift
//  Payroll
//
//  Created by Suresh Babu Rajendran on 04/07/26.
//

import Foundation
import SwiftUI
struct PayrollDetailView: View {

    let payroll: Payroll

    var body: some View {

        List {

            Section {

                VStack(alignment: .leading, spacing: 8) {

                    Text(payroll.createdDate.formatted(date: .abbreviated,
                                                       time: .omitted))
                        .font(.headline)

                    Text("\(payroll.employees.count) Employees")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

            }

            Section("Employees") {

                ForEach(payroll.employees) { employee in

                    EmployeeRow(employee: employee)
                }
            }

            Section("Payroll Summary") {

                SummaryRow(
                    title: "Total Wages",
                    value: payroll.totalAmount
                )

                if payroll.totalTaxes > 0 {

                    SummaryRow(
                        title: "Total Taxes",
                        value: payroll.totalTaxes
                    )
                }

                SummaryRow(
                    title: "Total Net",
                    value: payroll.totalNet,
                    isBold: true
                )
            }
        }
        .listStyle(.plain)
        .navigationTitle("Payroll")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct EmployeeRow: View {

    let employee: Employee

    var body: some View {

        VStack(alignment: .leading, spacing: 12) {

            HStack {

                Text(employee.name)
                    .font(.headline)

                Spacer()

                if employee.isExempt {

                    Label("Exempt", systemImage: "checkmark.seal.fill")
                        .font(.caption)
                        .foregroundStyle(.green)
                }
            }

            Divider()

            DetailRow(
                title: "Wages",
                value: employee.wages
            )

            DetailRow(
                title: "Taxes",
                value: employee.taxes
            )

            DetailRow(
                title: "Net",
                value: employee.net
            )
        }
        .padding(.vertical, 8)
    }
}

struct DetailRow: View {

    let title: String
    let value: Double

    var body: some View {

        HStack {

            Text(title)

            Spacer()

            Text(value,
                 format: .currency(code: "USD"))
                .monospacedDigit()
        }
    }
}

struct SummaryRow: View {

    let title: String
    let value: Double
    var isBold = false

    var body: some View {

        HStack {

            Text(title)
                .fontWeight(isBold ? .bold : .regular)

            Spacer()

            Text(value,
                 format: .currency(code: "USD"))
                .fontWeight(isBold ? .bold : .regular)
                .monospacedDigit()
        }
    }
}
