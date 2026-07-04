//
//  Employee.swift
//  Payroll
//
//  Created by Suresh Babu Rajendran on 04/07/26.
//

import Foundation
struct Employee: Identifiable {

    var id: UUID?

    var name: String

    var wages: Double

    var isExempt: Bool

    var taxes: Double {

        print(wages, isExempt)
            guard wages > 1000, !isExempt else {
                return 0
            }

            return wages * 0.05
        }

        var net: Double {
            wages - taxes
        }

}
