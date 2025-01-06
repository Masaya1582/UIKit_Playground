//
//  InAppMessagingModal.swift
//  UIKit_Playground
//
//  Created by MasayaNakakuki on 2025/01/06.
//

import Foundation
import UIKit

struct InAppMessagingContents {
    let title: String
    let body: String?
    let imageURL: URL?
    let buttonTitle: String?
    let buttonURL: URL?
}

final class InAppMessagingModal {
    static func show(
        on viewController: UIViewController,
        title: String,
        body: String?,
        imageURL: URL?,
        buttonTitle: String?,
        buttonURL: URL?
    ) {
        let contents = InAppMessagingContents(
            title: title,
            body: body,
            imageURL: imageURL,
            buttonTitle: buttonTitle,
            buttonURL: buttonURL
        )
        let inAppMessagingModalViewController = InAppMessagingModalViewController(inAppMessagingContents: contents)
        viewController.present(inAppMessagingModalViewController, animated: true)
    }
}
