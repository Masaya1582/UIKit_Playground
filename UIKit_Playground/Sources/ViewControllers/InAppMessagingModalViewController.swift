//
//  InAppMessagingModalViewController.swift
//  HerbertMember
//
//  Created by MasayaNakakuki on 2024/11/29.
//  Copyright © 2024 Fuller, Inc. All rights reserved.
//

import UIKit
import SafariServices

final class InAppMessagingModalViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var bodyLabel: UILabel!
    @IBOutlet private weak var messagingButton: DesignableButton!
    @IBOutlet private weak var rightTopCloseButton: UIButton!
    @IBOutlet private weak var backgroundCloseButton: UIButton!
    @IBOutlet private weak var inAppMessagingImageConstraint: NSLayoutConstraint!

    private let inAppMessagingContents: InAppMessagingContents

    // MARK: - Initialize
    init(inAppMessagingContents: InAppMessagingContents) {
        self.inAppMessagingContents = inAppMessagingContents
        super.init(nibName: Self.className, bundle: Self.bundle)
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = inAppMessagingContents.title
        bodyLabel.text = inAppMessagingContents.body
        bodyLabel.isHidden = inAppMessagingContents.body == nil
        messagingButton.setTitle(inAppMessagingContents.buttonTitle, for: .normal)
        messagingButton.isHidden = inAppMessagingContents.buttonTitle == nil
        if let url = inAppMessagingContents.imageURL {
            setImage(from: url, to: imageView)
        }
    }
    @IBAction func backgroundButton(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func rightCloseButton(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func detailButton(_ sender: Any) {
        guard let url = inAppMessagingContents.imageURL else { return }
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true)
    }

    func setImage(from url: URL, to imageView: UIImageView) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error downloading image: \(error)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Invalid response from server")
                return
            }
            guard let data = data, let image = UIImage(data: data) else {
                print("Invalid image data")
                return
            }
            DispatchQueue.main.async {
                imageView.image = image
            }
        }
        task.resume()
    }
}

// MARK: - SFSafariViewControllerDelegate
extension InAppMessagingModalViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true)
    }
}
