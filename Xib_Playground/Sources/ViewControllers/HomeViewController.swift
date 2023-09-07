//
//  HomeViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeViewController: UIViewController {
    // MARK: - Dependency
    typealias Dependency = Void

    // MARK: - Properties
    private let iceCreamSubject = BehaviorRelay<String>(value: "None")
    private let pizzaSubject = BehaviorRelay<String>(value: "None")
    private let disposeBag = DisposeBag()
    private let viewModel: Dependency

    // MARK: - Initialize
    init(dependency: Dependency) {
        self.viewModel = dependency
        super.init(nibName: Self.className, bundle: Self.bundle)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: viewModel)
    }

}

// MARK: - Bind
private extension HomeViewController {
    func bind(to viewModel: Dependency) {
        let combineLatestObservable = Observable.combineLatest(iceCreamSubject, pizzaSubject) { iceCream, pizza in
            return "Your like \(iceCream) ice cream, and your friend wants \(pizza) pizza!"

        }

        combineLatestObservable.subscribe(onNext: {  message in
            print(message)
        })
        .disposed(by: disposeBag)

        iceCreamSubject.accept("Chocolate")
        pizzaSubject.accept("Pepperoni")
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
