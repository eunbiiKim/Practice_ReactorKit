//
//  SceneDelegate.swift
//  Practice_ReactorKit
//
//  Created by eunbiiKim on 2022/11/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        let viewController = self.window?.rootViewController as? ViewController
        viewController?.reactor = CounterViewReactor()
    }
}

