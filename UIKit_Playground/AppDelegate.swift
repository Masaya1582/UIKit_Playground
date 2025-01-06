//
//  AppDelegate.swift
//  UIKit_Playground
//
//  Created by MasayaNakakuki on 2023/06/29.
//

import UIKit
import FirebaseInAppMessaging
import Firebase

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        InAppMessaging.inAppMessaging().messageDisplayComponent = InAppMessagingCustomComponent()
        Installations.installations().installationID { id, error in
            if let error = error {
                print("Error retrieving installation ID: \(error.localizedDescription)")
            } else if let id = id {
                print("Firebase Installation ID: \(id)")
            }
        }
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options _: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_: UIApplication, didDiscardSceneSessions _: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
