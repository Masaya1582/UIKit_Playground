//
//  HomeViewModel.swift
//  UIKit_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import RxCocoa
import RxSwift

protocol HomeViewModelInputs: AnyObject {
    var switchAccordion: PublishRelay<Void> { get }
}

protocol HomeViewModelOutputs: AnyObject {
    var isAccordionViewHidden: Driver<Bool> { get }
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
    let switchAccordion = PublishRelay<Void>()
    // MARK: - Output Sources
    let isAccordionViewHidden: Driver<Bool>

    // MARK: - Properties
    private let _isAccordionViewHidden = BehaviorRelay<Bool>(value: true)
    private let disposeBag = DisposeBag()

    // MARK: - Initialize
    init() {
        self.isAccordionViewHidden = _isAccordionViewHidden.asDriver(onErrorDriveWith: .empty())
        switchAccordion.asObservable()
            .withLatestFrom(isAccordionViewHidden)
            .map { !$0 }
            .bind(to: _isAccordionViewHidden)
            .disposed(by: disposeBag)
    }
}
