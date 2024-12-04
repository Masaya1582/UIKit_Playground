//
//  HomeViewController.swift
//  UIKit_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import RxCocoa
import RxSwift
import UIKit
import MapKit

final class HomeViewController: UIViewController, MKMapViewDelegate {
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
    private var mapView: MKMapView!
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
        mapView = MKMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self
        view.addSubview(mapView)
        let pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2D(latitude: 35.6812, longitude: 139.7671)
        pin.title = "カスタムピン"
        mapView.addAnnotation(pin)
        bind(to: viewModel)
    }

    private func setMapRegion(location: CLLocation, radius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: radius,
            longitudinalMeters: radius
        )
        mapView.setRegion(coordinateRegion, animated: true)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "customPin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.image = UIImage(systemName: "star.fill") // SF Symbolsを利用
        } else {
            annotationView?.annotation = annotation
        }

        return annotationView
    }
}

// MARK: - Bind
private extension HomeViewController {
    func bind(to _: Dependency) {
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
