//
//  HomeViewController.swift
//  Xib_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit
import RxSwift
import RxCocoa
import CoreLocation

final class HomeViewController: UIViewController {
    // MARK: - Dependency
    typealias Dependency = HomeViewModelType

    // MARK: - Properties
    @IBOutlet private weak var locationLabel: UILabel!

    private let locationManager = CLLocationManager()
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
        locationManager.delegate = self
        let region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: 37.911602426532674, longitude: 139.06191345009415),
                                      radius: 100,
                                      identifier: "Niigata Station")
        locationManager.startMonitoring(for: region)
    }

}

extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        locationLabel.text = "範囲内だぜ"
    }

    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        locationLabel.text = "範囲外だぜ"
    }
}

// MARK: - ViewControllerInjectable
extension HomeViewController: ViewControllerInjectable {}
