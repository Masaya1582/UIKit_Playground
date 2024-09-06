//
//  Calculator.swift
//  UIKit_Playground
//
//  Created by MasayaNakakuki on 2024/06/15.
//

import Foundation

class Calculator {
    func add(_ a: Int, _ b: Int) -> Int {
        return a + b
    }

    func subtract(_ a: Int, _ b: Int) -> Int {
        return a - b
    }

    func multiply(_ a: Int, _ b: Int) -> Int {
        return a * b
    }

    func divide(_ a: Int, _ b: Int) -> Int {
        guard b != 0 else {
            fatalError("Division by zero is not allowed")
        }
        return a / b
    }
}
