//
//  SecondTableViewCell.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2024/03/04.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class SecondTableViewCell: UITableViewCell {
    // MARK: - Properties
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!

    // MARK: - Initialize
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        priceLabel.text = nil
    }

    // MARK: - Setup
    func configure(with food: Food) {
        nameLabel.text = food.name
        priceLabel.text = food.price
    }

}
