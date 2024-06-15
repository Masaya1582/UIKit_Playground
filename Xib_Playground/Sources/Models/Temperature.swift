//
//  Temperature.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2024/06/16.
//

import Foundation

class TemperatureConverter {
    func celsiusToFahrenheit(_ celsius: Double) -> Double {
        return (celsius * 9/5) + 32
    }

    func fahrenheitToCelsius(_ fahrenheit: Double) -> Double {
        return (fahrenheit - 32) * 5/9
    }
}
