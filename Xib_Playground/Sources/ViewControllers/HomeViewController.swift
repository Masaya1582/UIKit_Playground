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
//    @IBOutlet private weak var tableView: UITableView! {
//        didSet {
//            tableView.registerCell(HomeTableViewCell.self)
//        }
//    }
//    @IBOutlet private weak var collectionView: UICollectionView! {
//        didSet {
//            collectionView.registerCell(HomeCollectionViewCell.self)
//        }
//    }
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
        view.backgroundColor = .white
        let button = UIButton()
        button.setTitle("Show Alert", for: .normal)
        button.backgroundColor = .lightGray
        button.frame.size = CGSize(width: 200, height: 60)
        button.center = view.center
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.addSubview(button)
        bind(to: viewModel)
    }

    @objc func buttonTapped() {
        let alert: UIAlertController = UIAlertController(title: "Title", message: "Message", preferredStyle: UIAlertController.Style.alert)
        alert.addTextField(configurationHandler: nil)
        alert.textFields?.first?.placeholder = "Input Text"
        alert.textFields?.first?.addTarget(self, action: #selector(textFieldDidChange), for: .allEditingEvents)
        let saveTitleAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (_: UIAlertAction?) -> Void in
            guard let text = alert.textFields?.first?.text, !text.isEmpty else {
                return
            }
            print(text)
        })
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cencel", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(saveTitleAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, text.count > 5 {
            textField.text = String(text.prefix(5))
        }
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
//
//        viewModel.outputs.<#Property#>
//            .drive(<#tableView or collectionView#>.rx.items) { [weak self] <#tableView or collectionView#>, row, element in
//                let indexPath = IndexPath(row: row, section: 0)
//               let cell = <#tableView or collectionView#>.dequeueReusableCell(<#TableViewCell or CollectionViewCell#>.self, for: indexPath)
//                cell.delegate = self
//                cell.configure(with: element)
//                return cell
//            }
//            .disposed(by: disposeBag)
//
//        viewModel.outputs.listItem
//            .drive(<#tableView or collectionView#>.rx.items) { [weak self] <#tableView or collectionView#>, row, element in
//                switch element {
//                case .<#enum Item1#>:
//                    guard let cell = <#tableView or collectionView#>.dequeueReusableCell(withIdentifier: "<#Identifier#>", for: [0, row]) as? <#TableView or CollectionView#> else {
//                        return UITableViewCell()
//                    }
//                    return cell
//                case .<#enum Item2#>(let <#property#>):
//                    guard let cell = <#tableView or collectionView#>.dequeueReusableCell(withIdentifier: "<#Identifier#>", for: [0, row]) as? <#TableView or CollectionView#> else {
//                        return UITableViewCell()
//                    }
//                    cell.delegate = self
//                    cell.configure(with: element)
//                    return cell
//                case .<#enum Item3#>:
//                    guard let cell = <#tableView or collectionView#>.dequeueReusableCell(withIdentifier: "<#Identifier#>", for: [0, row]) as? <#TableView or CollectionView#> else {
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
