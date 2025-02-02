//
//  HomeModel.swift
//  UIKit_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import Foundation

struct DefaultModel {
    var name: String
    var age: Int
    var height: Double
    var isHuman: Bool
    var type: PokemonType?

    private enum CodingKeys: String, CodingKey {
        case name
        case age
        case height
        case isHuman = "is_human"
        case type
    }
}

public enum PokemonType: String {
    case electric = "Electric"
    case fire = "Fire"
    case water = "Water"
    case grass = "Grass"
    case normal = "Normal"
}
