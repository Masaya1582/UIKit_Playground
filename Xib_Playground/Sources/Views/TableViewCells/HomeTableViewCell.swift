//
//  HomeTableViewCell.swift
//  Xib_Playground
//
//  Created by 中久木 雅哉(Nakakuki Masaya) on 2024/05/10.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeTableViewCell: UITableViewCell {
    // MARK: - Properties

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
    }
}
