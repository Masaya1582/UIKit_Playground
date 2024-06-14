//
//  Xib_PlaygroundTests.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2024/06/15.
//

import XCTest
@testable import Xib_Playground

class CalculatorTests: XCTestCase {
    var calculator: Calculator!

    override func setUp() {
        super.setUp()
        calculator = Calculator()
    }

    override func tearDown() {
        calculator = nil
        super.tearDown()
    }

    func testAdd() {
        XCTAssertEqual(calculator.add(2, 3), 5, "2 + 3 must be equal to 5")
    }

    func testSubtract() {
        XCTAssertEqual(calculator.subtract(5, 3), 2)
    }

    func testMultiply() {
        XCTAssertEqual(calculator.multiply(2, 3), 6)
    }

    func testDivide() {
        XCTAssertEqual(calculator.divide(6, 3), 2)
    }

    func testDivideByZero() {
        XCTAssertFatalError {
            _ = calculator.divide(6, 0)
        }
    }
}

extension XCTestCase {
    func XCTAssertFatalError(expectedMessage: String? = nil, file: StaticString = #file, line: UInt = #line, _ block: () throws -> Void) {
        var assertionMessage = "No fatal error thrown"
        var assertion = false
        if let message = expectedMessage {
            assertionMessage = message
        }

        XCTAssertFalse(assertion, assertionMessage, file: file, line: line)
    }
}
