//
//  InAppMessagingCustomComponent.swift
//  UIKit_Playground
//
//  Created by MasayaNakakuki on 2025/01/06.
//

import Firebase
import FirebaseInAppMessaging

private enum IAMDisplay {
    case unknown
    case card(InAppMessagingCardDisplay)
    case modal(InAppMessagingModalDisplay)
    case banner(InAppMessagingBannerDisplay)
    case imageOnly(InAppMessagingImageOnlyDisplay)

    init(_ messageForDisplay: InAppMessagingDisplayMessage) {
        switch messageForDisplay.type {
        case .card:
            self = (messageForDisplay as? InAppMessagingCardDisplay).map { .card($0) } ?? .unknown
        case .modal:
            self = (messageForDisplay as? InAppMessagingModalDisplay).map { .modal($0) } ?? .unknown
        case .banner:
            self = (messageForDisplay as? InAppMessagingBannerDisplay).map { .banner($0) } ?? .unknown
        case .imageOnly:
            self = (messageForDisplay as? InAppMessagingImageOnlyDisplay).map { .imageOnly($0) } ?? .unknown
        @unknown default:
            self = .unknown
        }
    }
}

final class InAppMessagingCustomComponent: InAppMessagingDisplay {
    func displayMessage(_ messageForDisplay: InAppMessagingDisplayMessage, displayDelegate: InAppMessagingDisplayDelegate) {
        DispatchQueue.main.async {
            displayDelegate.impressionDetected?(for: messageForDisplay)
            guard let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene else {
                return
            }
            guard let window = scene.windows.first(where: { $0.isKeyWindow }) else {
                return
            }
            switch IAMDisplay(messageForDisplay) {
            case let .modal(modal):
                InAppMessagingModal.show(
                    on: window.rootViewController ?? UIViewController(),
                    title: modal.title,
                    body: modal.bodyText,
                    imageURL: URL(string: modal.imageData?.imageURL ?? ""),
                    buttonTitle: modal.actionButton?.buttonText,
                    buttonURL: modal.actionURL
                )
            case .card, .banner, .imageOnly, .unknown:
                return
            }
        }
    }
}
