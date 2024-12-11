//
//  HomeViewModel.swift
//  UIKit_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import Action
import RxCocoa
import RxSwift
import Foundation

protocol HomeViewModelInputs: AnyObject {
    var isScrolling: BehaviorRelay<Bool> { get }
}

protocol HomeViewModelOutputs: AnyObject {
    var pokemon: Driver<[Pokemon]> { get }
    var buttonAlpha: Driver<CGFloat> { get }
}

protocol HomeViewModelType: AnyObject {
    var inputs: HomeViewModelInputs { get }
    var outputs: HomeViewModelOutputs { get }
}

final class HomeViewModel: HomeViewModelType, HomeViewModelInputs, HomeViewModelOutputs {
    // MARK: - Properties
    var inputs: HomeViewModelInputs { return self }
    var outputs: HomeViewModelOutputs { return self }

    // MARK: - Input Sources
    let isScrolling = BehaviorRelay<Bool>(value: false)
    // MARK: - Output Sources
    let pokemon: Driver<[Pokemon]>
    let buttonAlpha: Driver<CGFloat>

    // MARK: - Properties
    private let pokemonArray: [Pokemon] = [
        Pokemon(name: "Pikachu", type: "Electric", level: 10),
        Pokemon(name: "Charmander", type: "Fire", level: 8),
        Pokemon(name: "Bulbasaur", type: "Grass", level: 7),
        Pokemon(name: "Squirtle", type: "Water", level: 9),
        Pokemon(name: "Jigglypuff", type: "Fairy", level: 6),
        Pokemon(name: "Geodude", type: "Rock", level: 12),
        Pokemon(name: "Abra", type: "Psychic", level: 11),
        Pokemon(name: "Machop", type: "Fighting", level: 10),
        Pokemon(name: "Gastly", type: "Ghost", level: 8),
        Pokemon(name: "Snorlax", type: "Normal", level: 15),
        Pokemon(name: "Pikachu", type: "Electric", level: 10),
        Pokemon(name: "Charmander", type: "Fire", level: 8),
        Pokemon(name: "Bulbasaur", type: "Grass", level: 7),
        Pokemon(name: "Squirtle", type: "Water", level: 9),
        Pokemon(name: "Jigglypuff", type: "Fairy", level: 6),
        Pokemon(name: "Geodude", type: "Rock", level: 12),
        Pokemon(name: "Abra", type: "Psychic", level: 11),
        Pokemon(name: "Machop", type: "Fighting", level: 10),
        Pokemon(name: "Gastly", type: "Ghost", level: 8),
        Pokemon(name: "Snorlax", type: "Normal", level: 15),
        Pokemon(name: "Pikachu", type: "Electric", level: 10),
        Pokemon(name: "Charmander", type: "Fire", level: 8),
        Pokemon(name: "Bulbasaur", type: "Grass", level: 7),
        Pokemon(name: "Squirtle", type: "Water", level: 9),
        Pokemon(name: "Jigglypuff", type: "Fairy", level: 6),
        Pokemon(name: "Geodude", type: "Rock", level: 12),
        Pokemon(name: "Abra", type: "Psychic", level: 11),
        Pokemon(name: "Machop", type: "Fighting", level: 10),
        Pokemon(name: "Gastly", type: "Ghost", level: 8),
        Pokemon(name: "Snorlax", type: "Normal", level: 15),
        Pokemon(name: "Pikachu", type: "Electric", level: 10),
        Pokemon(name: "Charmander", type: "Fire", level: 8),
        Pokemon(name: "Bulbasaur", type: "Grass", level: 7),
        Pokemon(name: "Squirtle", type: "Water", level: 9),
        Pokemon(name: "Jigglypuff", type: "Fairy", level: 6),
        Pokemon(name: "Geodude", type: "Rock", level: 12),
        Pokemon(name: "Abra", type: "Psychic", level: 11),
        Pokemon(name: "Machop", type: "Fighting", level: 10),
        Pokemon(name: "Gastly", type: "Ghost", level: 8),
        Pokemon(name: "Snorlax", type: "Normal", level: 15)
    ]
    private let _buttonAlpha = BehaviorRelay<CGFloat>(value: 1.0)
    private let _pokemon = BehaviorRelay<[Pokemon]>(value: [])
    private let disposeBag = DisposeBag()

    // MARK: - Initialize
    init() {
        self.buttonAlpha = _buttonAlpha.asDriver(onErrorDriveWith: .empty())
        _pokemon.accept(pokemonArray)
        pokemon = _pokemon.asDriver(onErrorDriveWith: .empty())

        isScrolling
            .map { $0 ? 0.4 : 1.0 }
            .bind(to: _buttonAlpha)
            .disposed(by: disposeBag)
    }
}

// MARK: - Item
// extension HomeViewModel {
//    enum ListItem {
//        case header
//        case shop(Content)
//        case footer
//    }
// }
