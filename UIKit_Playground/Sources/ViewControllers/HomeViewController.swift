//
//  HomeViewController.swift
//  UIKit_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import RxCocoa
import RxSwift
import UIKit

final class HomeViewController: UIViewController {
    // MARK: - Dependency

    typealias Dependency = HomeViewModelType

    // MARK: - Properties
    @IBOutlet private weak var accrodionButton: UIButton!
    @IBOutlet private weak var accrodionView: UIView!

    private lazy var viewModel: HomeViewModelType = { fatalError("Use (dependency: ) at initialize controller") }()
    private let disposeBag = DisposeBag()

    // MARK: - Initialize
    init(dependency: Dependency) {
        super.init(nibName: Self.className, bundle: Self.bundle)
        viewModel = dependency
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
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
    func bind(to _: Dependency) {
        accrodionButton.rx.tap.asSignal()
            .emit(to: viewModel.inputs.switchAccrodion)
            .disposed(by: disposeBag)

        viewModel.outputs.isAccordionViewHidden
            .drive { [weak self] isAccordionViewHidden in
                self?.accrodionView.isHidden = isAccordionViewHidden
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
