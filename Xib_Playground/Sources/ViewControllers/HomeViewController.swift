//
//  HomeViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class HomeViewController: UIViewController {
    // MARK: - Dependency
    typealias Dependency = Void

    // MARK: - Properties
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
//        <#Button#>.rx.tap.asSignal()
//            .emit(onNext: { [weak self] in
//                <#Actions#>
//            })
//            .disposed(by: disposeBag)
//
//        <#TextField#>.rx.text.orEmpty
//            .bind(to: <#ViewModel#>.inputs.<#Property#>)
//            .disposed(by: disposeBag)
//
//        viewModel.outputs.<#Property#>
//            .drive { [weak self] <#Property#> in
//                <#Actions#>
//            }
//            .disposed(by: disposeBag)
//        viewModel.outputs.listItem
//            .drive(tableView.rx.items) { tableView, row, element in
//                switch element {
//                case .header:
//                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell", for: [0, row]) as? HeaderTableViewCell else {
//                        return UITableViewCell()
//                    }
//                    return cell
//                case .content(let president):
//                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContentTableViewCell", for: [0, row]) as? ContentTableViewCell else {
//                        return UITableViewCell()
//                    }
//                    cell.configure(with: president)
//                    return cell
//                case .footer:
//                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "FooterTableViewCell", for: [0, row]) as? FooterTableViewCell else {
//                        return UITableViewCell()
//                    }
//                    return cell
//                }
//            }
//            .disposed(by: disposeBag)
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
