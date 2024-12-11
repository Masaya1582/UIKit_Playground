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
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var typeLabel: UILabel!
    @IBOutlet private weak var levelLabel: UILabel!
    weak var delegate: HomeTableViewCellDelegate?
    private var disposeBag = DisposeBag()

    // MARK: - Initialize
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        typeLabel.text = nil
        levelLabel.text = nil
        disposeBag = DisposeBag()
    }

    // MARK: - Setup
    func configure(with pokemon: Pokemon) {
        nameLabel.text = pokemon.name
        typeLabel.text = pokemon.type
        levelLabel.text = "Level: \(pokemon.level)"
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
