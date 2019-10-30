//
//  SceneDelegate.swift
//  Reciplease
//
//  Created by Alexandre Quiblier on 01/10/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator!
    var context: Context!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: scene)
        window!.makeKeyAndVisible()

        coordinator = AppCoordinator(sceneDelegate: self)
        coordinator.start()
    }

  
    func sceneDidEnterBackground(_ scene: UIScene) {
       
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}


