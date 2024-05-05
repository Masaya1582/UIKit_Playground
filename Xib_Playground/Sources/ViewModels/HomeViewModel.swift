// 
//  HomeViewModel.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import RxSwift
import RxCocoa
import Action

protocol HomeViewModelInputs: AnyObject {
    var load: PublishRelay<Void> { get }
}

protocol HomeViewModelOutputs: AnyObject {
    var isLoading: Driver<Bool> { get }
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
    let load = PublishRelay<Void>()
    // MARK: - Output Sources
    let isLoading: Driver<Bool>

    // MARK: - Properties
    private let _isLoading = BehaviorRelay<Bool>(value: false)
    private let disposeBag = DisposeBag()

    // MARK: - Initialize
    init() {
        self.isLoading = _isLoading.asDriver(onErrorDriveWith: .empty())
        load.asObservable()
            .withLatestFrom(_isLoading)
            .map { !$0 }
            .bind(to: _isLoading)
            .disposed(by: disposeBag)
    }

}
