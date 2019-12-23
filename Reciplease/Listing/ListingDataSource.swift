//
//  ListingDataSource.swift
//  Reciplease
//
//  Created by Alexandre Quiblier on 08/10/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

final class ListingDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Private
    
    private var items: [VisibleRecipe] = []
    
    // MARK: - Public
    
    var imageProvider: ImageProvider!
    
    func update(with items: [VisibleRecipe]) {
        self.items = items
    }
    
    var didSelectItemAtIndex: ((Int) -> Void)?
    
    // MARK: - Initializer
    
    init(imageProvider: ImageProvider) {
        self.imageProvider = imageProvider
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.item < items.count else { fatalError() }
        let visibleRecipe = items[indexPath.item]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListingTableViewCell", for: indexPath) as! ListingTableViewCell
        cell.configure(with: visibleRecipe, imageProvider: imageProvider)
        return cell
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.item < items.count else {
            assertionFailure("Index out of Range")
            return
        }
        
        let index = indexPath.item
        didSelectItemAtIndex?(index)
    }
}

