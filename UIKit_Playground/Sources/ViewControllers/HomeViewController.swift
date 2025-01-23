//
//  HomeViewController.swift
//  UIKit_Playground
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
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.estimatedRowHeight = 60
            tableView.rowHeight = 60
        }
    }

    private var dataSource: RxTableViewSectionedReloadDataSource<SectionModel<String, Menu>>?
    private let disposeBag = DisposeBag()

    // MARK: - Initialize
    init(dependency: Dependency) {
        super.init(nibName: Self.className, bundle: Self.bundle)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
}

// MARK: - Binding
extension HomeViewController {
    func bind() {
        // DataSource
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Menu>>(configureCell: { _, _, _, element -> UITableViewCell in
            let cell = UITableViewCell()
            cell.textLabel?.font = .systemFont(ofSize: 14)
            cell.textLabel?.textColor = Asset.Colors.black.color
            cell.textLabel?.textAlignment = .left
            cell.textLabel?.text = element.title
            return cell
        }, titleForHeaderInSection: { dataSource, section -> String? in
            return dataSource[section].model
        })
        self.dataSource = dataSource

        Driver.just([SectionModel(model: "セクション1", items: [Menu.section1]),
                     SectionModel(model: "セクション2", items: [Menu.section2]),
                     SectionModel(model: "セクション3", items: [Menu.section3]),
                     SectionModel(model: "セクション4", items: [Menu.section4])])
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(Menu.self).asDriver()
            .drive(onNext: { sectionType in
                switch sectionType {
                case .section1:
                    print("セクション1がタップされたよ")
                case .section2:
                    print("セクション2がタップされたよ")
                case .section3:
                    print("セクション3がタップされたよ")
                case .section4:
                    print("セクション4がタップされたよ")
                }
            })
            .disposed(by: disposeBag)

        tableView.rx.itemSelected.asDriver()
            .drive(onNext: { [weak self] indexPath in
                self?.tableView.deselectRow(at: indexPath, animated: true)
            })
            .disposed(by: disposeBag)

        tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
}

// MARK: - UITableView Delegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
}

// MAKR: - Menu
private extension HomeViewController {
    enum Menu {
        case section1
        case section2
        case section3
        case section4

        // MARK: - Properties
        var title: String {
            switch self {
            case .section1:
                return "セクション1アイテム"
            case .section2:
                return "セクション2アイテム"
            case .section3:
                return "セクション3アイテム"
            case .section4:
                return "セクション4アイテム"
            }
        }
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
