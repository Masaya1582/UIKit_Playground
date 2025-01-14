//
//  HomeTableViewCell.swift
//  UIKit_Playground
//
//  Created by 中久木 雅哉(Nakakuki Masaya) on 2024/05/10.
//

import RxCocoa
import RxSwift
import UIKit

protocol HomeTableViewCellDelegate: AnyObject {
    func homeTableViewCellDidTapButton()
}

final class HomeTableViewCell: UITableViewCell {
    // MARK: - Properties
    weak var delegate: HomeTableViewCellDelegate?
    private var disposeBag = DisposeBag()

    // MARK: - Initialize
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    // MARK: - Setup
    func configure() {
        bind()
    }
}

private extension HomeTableViewCell {
    func bind() {
//        <#Button#>.rx.tap.asSignal()
//            .emit(onNext: { [weak self] in
//                <#Actions#>
//            })
//            .disposed(by: disposeBag)
    }
}
