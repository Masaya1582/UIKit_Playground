//
//  HomeViewModel.swift
//  UIKit_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import Action
import RxCocoa
import RxSwift

protocol HomeViewModelInputs: AnyObject {}

protocol HomeViewModelOutputs: AnyObject {
    // var items: Driver<[HomeViewModel.ListItem]> { get }
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
    // MARK: - Output Sources
    // let items: Driver<[ListItem]>

    // MARK: - Properties
    // private let loadAction: Action<Void, DefaultModel>
    private let disposeBag = DisposeBag()

    // MARK: - Initialize
    init() {}
}

// MARK: - Item
// extension HomeViewModel {
//    enum ListItem {
//        case header
//        case shop(Content)
//        case footer
//    }
// }
