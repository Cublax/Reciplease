//
//  SceneDelegate.swift
//  Reciplease
//
//  Created by Alexandre Quiblier on 01/10/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit
import CoreData

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var coordinator: AppCoordinator!
    var context: Context!
    
    // MARK: - Private properties
    
    private var imageCache: NSCache<Key, Object>!

    private var stack: CoreDataStack!
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        window!.makeKeyAndVisible()
        imageCache = NSCache<Key, Object>()
        
        let client = HTTPClient(engine: .urlSession(.default))
        
        let imageRepository = ImageRepository(networkClient: client)
        
        let imageProvider = ImageProvider(repository: imageRepository,
                                          cache: self.imageCache)
        
        stack = CoreDataStack()
        
        context = Context(networkClient: client,
                          imageProvider: imageProvider,
                          stack: stack)
        
        coordinator = AppCoordinator(sceneDelegate: self,
                                     context: context)
        coordinator.start()
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        stack.saveContext()
    }
}

final class CoreDataStack {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
