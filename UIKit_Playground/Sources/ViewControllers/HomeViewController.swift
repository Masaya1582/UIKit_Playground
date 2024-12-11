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
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.registerCell(HomeTableViewCell.self)
        }
    }
    @IBOutlet private weak var sampleButton: DesignableButton!

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
        viewModel.outputs.pokemon
            .drive(tableView.rx.items) { tableView, row, element in
                let indexPath = IndexPath(row: row, section: 0)
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell else {
                    return UITableViewCell()
                }
                cell.configure(with: element)
                return cell
            }
            .disposed(by: disposeBag)
        viewModel.outputs.buttonAlpha
            .drive { [weak self] alpha in
                self?.sampleButton.alpha = alpha
            }
            .disposed(by: disposeBag)
        Observable.merge(
            tableView.rx.didEndDragging
                .map { [weak self] _ in self?.tableView.isDragging ?? false }
                .distinctUntilChanged(),
            tableView.rx.contentOffset
                .map { [weak self] _ in self?.tableView.isDragging ?? false }
                .distinctUntilChanged()
        )
        .bind(to: viewModel.inputs.isScrolling)
        .disposed(by: disposeBag)

    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
