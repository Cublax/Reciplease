//
//  RecipeDataSource.swift
//  Reciplease
//
//  Created by Alexandre Quiblier on 08/10/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//
import UIKit

final class RecipeDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
              return 0
          }
          
          func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
              let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeTableViewCell", for: indexPath) as! RecipeTableViewCell
              return cell
          }
    
    // MARK: - UITableViewDataSource
   
}
