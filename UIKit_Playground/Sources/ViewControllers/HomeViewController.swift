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
    // MARK: - Properties
    @IBOutlet private weak var accrodionButton: UIButton!
    @IBOutlet private weak var accrodionView: UIView!
    @IBOutlet private weak var accordionViewHeightConstraint: NSLayoutConstraint!

    private lazy var viewModel = HomeViewModel()
    private let disposeBag = DisposeBag()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: viewModel)
    }
}

// MARK: - Bind
private extension HomeViewController {
    func bind(to: HomeViewModelType) {
        // アコーディオンタップ
        accrodionButton.rx.tap.asSignal()
            .emit(to: viewModel.inputs.switchAccordion)
            .disposed(by: disposeBag)

        // isHidden制御
        viewModel.outputs.isAccordionViewHidden
            .drive(onNext: { [weak self] isAccordionViewHidden in
                guard let self = self else { return }
                if !isAccordionViewHidden {
                    self.accrodionView.isHidden = false
                }
                UIView.animate(withDuration: 0.3, animations: {
                    self.accordionViewHeightConstraint.constant = isAccordionViewHidden ? 0 : 160
                    self.view.layoutIfNeeded()
                    self.accrodionView.alpha = isAccordionViewHidden ? 0.0 : 1.0
                }, completion: { _ in
                    if isAccordionViewHidden {
                        self.accrodionView.isHidden = true
                    }
                })
            })
            .disposed(by: disposeBag)
    }
}
