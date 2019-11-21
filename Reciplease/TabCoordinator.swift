//
//  TabCoordinator.swift
//  Reciplease
//
//  Created by Alexandre Quiblier on 01/10/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

enum ViewControllerItem: Int {
    case search = 0
    case favorite = 1
}

protocol TabBarSourceType {
    var items: [UINavigationController] {get set}
}

final class TabBarSource: TabBarSourceType {
    var items: [UINavigationController] = [
        UINavigationController(nibName: nil, bundle: nil),
        UINavigationController(nibName: nil, bundle: nil)
    ]
    
    init() {
        tabBarIconInitializer()
    }
    
    private func tabBarIconInitializer() {
        UITabBar.appearance().barTintColor = #colorLiteral(red: 0.2134923041, green: 0.2007651627, blue: 0.196667999, alpha: 1)
        UITabBar.appearance().tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        let searchIcon = UIImage(systemName: "magnifyingglass.circle")
        let filledSearchIcon = UIImage(systemName: "magnifyingglass.circle.fill")
        self[.search].tabBarItem = UITabBarItem(title: "Search", image: searchIcon, selectedImage: filledSearchIcon)
        let favoriteIcon = UIImage(systemName: "heart")
        let filledFavoriteIcon = UIImage(systemName: "heart.fill")
        self[.favorite].tabBarItem = UITabBarItem(title: "Favorite", image: favoriteIcon, selectedImage: filledFavoriteIcon)
    }
}

extension TabBarSourceType {
    subscript(item: ViewControllerItem) -> UINavigationController {
        get {
            guard !items.isEmpty, item.rawValue < items.count, item.rawValue >= 0 else {
                fatalError("Item does not exist")
            }
            return items[item.rawValue]
        }
    }
}

final class TabCoordinator: NSObject {
    
    // MARK: - Properties
    
    private let presenter: UIWindow
    
    private let tabBarController: UITabBarController
    
    private let screens: Screens
    
    private var searchCoordinator: SearchCoordinator?
    
    private var favoriteCoordinator: FavoriteCoordinator?
    
    private var source: TabBarSource = TabBarSource()
    
    // MARK: - Initializer
    
    init(presenter: UIWindow, context: Context) {
        self.presenter = presenter
        
        self.screens = Screens(context: context)
        tabBarController = UITabBarController(nibName: nil, bundle: nil)
        tabBarController.viewControllers = source.items
        tabBarController.selectedViewController = source[.search]
        super.init()
        
        tabBarController.delegate = self
    }
    
    func start() {
        presenter.rootViewController = tabBarController
        showSearch()
    }
    
    private func showSearch() {
        searchCoordinator = SearchCoordinator(presenter: source[.search], screens: screens)
        searchCoordinator?.start()
    }
    
    private func showFavorite() {
        favoriteCoordinator = FavoriteCoordinator(presenter: source[.favorite], screens: screens)
        favoriteCoordinator?.start()
    }
}

extension TabCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let index = tabBarController.selectedIndex
        guard index < source.items.count, let item = ViewControllerItem(rawValue: index) else {
            fatalError("Index out of range")
        }
        
        switch item {
        case .search:
            showSearch()
        case .favorite:
            showFavorite()
        }
    }
}
