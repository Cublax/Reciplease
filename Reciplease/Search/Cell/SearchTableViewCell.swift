//
//  SearchCell.swift
//  Reciplease
//
//  Created by Alexandre Quiblier on 08/10/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

final class SearchTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var ingredientLabel: UILabel!
    
    // MARK: - Configure
    
    func configure(with title: String) {
        self.ingredientLabel.text = title
    }
}
