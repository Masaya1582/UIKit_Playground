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
    var manageCount: PublishRelay<Void> { get }
    var resetCount: PublishRelay<Void> { get }
}

protocol HomeViewModelOutputs: AnyObject {
    var count: Driver<Double> { get }
    var shouldHideResetButton: Driver<Bool> { get }
    var isTimerRunning: Driver<Bool> { get }
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
    let manageCount = PublishRelay<Void>()
    let resetCount = PublishRelay<Void>()
    // MARK: - Output Sources
    let count: Driver<Double>
    let shouldHideResetButton: Driver<Bool>
    let isTimerRunning: Driver<Bool>

    // MARK: - Properties
    private let _count = BehaviorRelay<Double>(value: 0.0)
    private let _shouldHideResetButton = BehaviorRelay<Bool>(value: true)
    private let _isTimerRunning = BehaviorRelay<Bool>(value: false)
    private var timer: Disposable?
    private let disposeBag = DisposeBag()

    // MARK: - Initialize
    init() {
        self.count = _count.asDriver(onErrorDriveWith: .empty())
        self.shouldHideResetButton = _shouldHideResetButton.asDriver(onErrorDriveWith: .empty())
        self.isTimerRunning = _isTimerRunning.asDriver(onErrorDriveWith: .empty())

        manageCount
            .subscribe(onNext: { [weak self] _ in
                guard let strongSelf = self else { return }
                if strongSelf._isTimerRunning.value == true {
                    strongSelf.timer?.dispose()
                    strongSelf._isTimerRunning.accept(false)
                } else {
                    strongSelf.timer = Observable<Int>.interval(.milliseconds(100), scheduler: MainScheduler.instance)
                        .subscribe(onNext: { _ in
                            let newCount = strongSelf._count.value + 0.1
                            let formattedCount = Double(round(10 * newCount) / 10)
                            strongSelf._count.accept(formattedCount)
                            strongSelf._shouldHideResetButton.accept(false)
                        })
                    strongSelf._isTimerRunning.accept(true)
                }
            })
            .disposed(by: disposeBag)

        resetCount
            .subscribe(onNext: { [weak self] _ in
                self?._count.accept(0.0)
                self?._shouldHideResetButton.accept(true)
                self?.timer?.dispose()
                self?._isTimerRunning.accept(false)
            })
            .disposed(by: disposeBag)
    }

}
