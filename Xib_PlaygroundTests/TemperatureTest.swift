//
//  TemperatureTest.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2024/06/16.
//

import XCTest
@testable import Xib_Playground

class TemperatureConverterTest: XCTestCase {
    var converter: TemperatureConverter!

    override func setUp() {
        super.setUp()
        converter = TemperatureConverter()
    }

    override func tearDown() {
        converter = nil
        super.tearDown()
    }

    func testCelsiusToFarenheit() {
        XCTAssertEqual(converter.celsiusToFahrenheit(100), 212, "100°C should be 212°F")
        XCTAssertEqual(converter.celsiusToFahrenheit(-40), -40, "-40°C should be -40°F")
    }

    func testFahrenheitToCelsius() {
        XCTAssertEqual(converter.fahrenheitToCelsius(32), 0, "32°F should be 0°C")
        XCTAssertEqual(converter.fahrenheitToCelsius(212), 100, "212°F should be 100°C")
        XCTAssertEqual(converter.fahrenheitToCelsius(-40), -40, "-40°F should be -40°C")
    }

    func testCelsiusToFahrenheitEdgeCases() {
        XCTAssertEqual(converter.celsiusToFahrenheit(37.7778), 100, accuracy: 0.0001, "37.7778°C should be approximately 100°F")
    }

    func testFahrenheitToCelsiusEdgeCases() {
        XCTAssertEqual(converter.fahrenheitToCelsius(100), 37.7778, accuracy: 0.0001, "100°F should be approximately 37.7778°C")
    }

}
