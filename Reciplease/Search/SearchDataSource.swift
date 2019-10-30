//
//  SearchDataSource.swift
//  Reciplease
//
//  Created by Alexandre Quiblier on 08/10/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

final class SearchDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    
    // MARK: - Private
    
    private var ingredients: [String] = []
    
    // MARK: - Public
    
    func update(with ingredient: [String]) {
        ingredients = ingredient
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
          }
          
          func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard indexPath.item < ingredients.count else { fatalError() }
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
            cell.configure(with: ingredients[indexPath.row])
            return cell
          }
}
