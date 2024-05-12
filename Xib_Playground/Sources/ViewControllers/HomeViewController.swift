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
    typealias Dependency = HomeViewModelType

    // MARK: - Properties
    @IBOutlet private weak var countLabel: UILabel!
    @IBOutlet private weak var startStopButton: DesignableButton!
    @IBOutlet private weak var resetButton: DesignableButton!

    private lazy var viewModel: HomeViewModelType = { fatalError("Use (dependency: ) at initialize controller") }()
    private let disposeBag = DisposeBag()

    // MARK: - Initialize
    init(dependency: Dependency) {
        super.init(nibName: Self.className, bundle: Self.bundle)
        self.viewModel = dependency
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
        // 開始 & ストップ
        startStopButton.rx.tap.asSignal()
            .emit(onNext: { _ in
                viewModel.inputs.manageCount.accept(())
            })
            .disposed(by: disposeBag)

        // リセット
        resetButton.rx.tap.asSignal()
            .emit(to: viewModel.inputs.resetCount)
            .disposed(by: disposeBag)

        // タイマー表示
        viewModel.outputs.count
            .map { String($0) }
            .drive(countLabel.rx.text)
            .disposed(by: disposeBag)

        // リセットボタン表示
        viewModel.outputs.isResetButtonHidden
            .drive { [weak self] shouldHideResetButton in
                self?.resetButton.isHidden = shouldHideResetButton
                self?.startStopButton.setTitle(shouldHideResetButton ? "Start" : "Stop", for: .normal)
            }
            .disposed(by: disposeBag)

        // タイマー稼働状態
        viewModel.outputs.isTimerRunning
            .drive { [weak self] isTimerRunning in
                self?.startStopButton.setTitle(isTimerRunning ? "Stop" : "Start", for: .normal)
                self?.startStopButton.backgroundColor = isTimerRunning ? Asset.Colors.alertRed.color : Asset.Colors.pink.color
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
