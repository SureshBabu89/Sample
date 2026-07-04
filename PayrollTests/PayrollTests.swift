//
//  PayrollTests.swift
//  PayrollTests
//
//  Created by Suresh Babu Rajendran on 03/07/26.
//

import XCTest
@testable import Payroll

final class PayrollTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTaxIsZero_WhenWagesLessThan1000() {

         let employee = Employee(
             name: "Sarah",
             wages: 900,
             isExempt: false
         )

         XCTAssertEqual(employee.taxes, 0)
     }

     func testTaxIsZero_WhenEmployeeIsExempt() {

         let employee = Employee(
             name: "James",
             wages: 2000,
             isExempt: true
         )

         XCTAssertEqual(employee.taxes, 0)
     }

     func testTaxIsFivePercent_WhenEligible() {

         let employee = Employee(
             name: "Laura",
             wages: 2000,
             isExempt: false
         )

         XCTAssertEqual(employee.taxes, 100)
     }

     func testNetAmount() {

         let employee = Employee(
             name: "Laura",
             wages: 2000,
             isExempt: false
         )

         XCTAssertEqual(employee.net, 1900)
     }

    func testPayrollSummary() {

        let payroll = Payroll(id: UUID(),createdDate: Date(), employees: [

            Employee(
                name: "Sarah",
                wages: 900,
                isExempt: false
            ),

            Employee(
                name: "James",
                wages: 1900,
                isExempt: true
            ),

            Employee(
                name: "Laura",
                wages: 2000,
                isExempt: false
            )
        ])

        XCTAssertEqual(payroll.totalAmount, 4800)
        XCTAssertEqual(payroll.totalTaxes, 100)
        XCTAssertEqual(payroll.totalNet, 4700)
    }


    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        // XCTest Documentation
        // https://developer.apple.com/documentation/xctest
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

final class MockPayrollRepository: PayrollRepository {

    private(set) var payrolls: [Payroll] = []

    func fetchPayrolls() throws -> [Payroll] {
        payrolls
    }

    func save(_ payroll: Payroll) throws {
        payrolls.append(payroll)
    }

    func delete(_ payroll: Payroll) throws {
        payrolls.removeAll { $0.id == payroll.id }
    }
}

@Observable
final class PayrollListViewModel {

    private let repository: PayrollRepository

    private(set) var payrolls: [Payroll] = []

    init(repository: PayrollRepository) {
        self.repository = repository
    }

    func loadPayrolls() async throws {
        payrolls = try await repository.fetchPayrolls()
    }
}

import XCTest

final class PayrollListViewModelTests: XCTestCase {

    private var repository: MockPayrollRepository!
    private var viewModel: PayrollListViewModel!

    override func setUp() {
        super.setUp()

        repository = MockPayrollRepository()
        viewModel = PayrollListViewModel(repository: repository)
    }

    override func tearDown() {
        repository = nil
        viewModel = nil

        super.tearDown()
    }

    func testLoadPayrolls() async throws {

        let payroll = Payroll(id:UUID(), createdDate: Date(), employees: [])

        try await repository.save(payroll)

        try await viewModel.loadPayrolls()

        XCTAssertEqual(viewModel.payrolls.count, 1)
    }

    func testLoadPayrolls_WhenRepositoryEmpty() async throws {

        try await viewModel.loadPayrolls()

        XCTAssertTrue(viewModel.payrolls.isEmpty)
    }
}


//final class CreatePayrollViewModelTests: XCTestCase {
//
//    var viewModel: CreatePayrollViewModel!
//
//    override func setUp() {
//        super.setUp()
//
//        viewModel = CreatePayrollViewModel()
//    }
//
//    override func tearDown() {
//        viewModel = nil
//
//        super.tearDown()
//    }
//
//    @MainActor func testAddEmployee() {
//
//        viewModel.addEmployee()
//
//        XCTAssertEqual(viewModel.employees.count, 1)
//    }
//
//    @MainActor func testAddMultipleEmployees() {
//
//        viewModel.addEmployee()
//
//        viewModel.addEmployee(
//
//        XCTAssertEqual(viewModel.employees.count, 2)
//    }
//}
