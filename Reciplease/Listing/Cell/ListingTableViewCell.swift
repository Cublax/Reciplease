//
//  ListingTableViewCell.swift
//  Reciplease
//
//  Created by Alexandre Quiblier on 08/10/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

final class ListingTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var dishNameLabel: UILabel!
    @IBOutlet weak var dishDescriptionLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var preparationTimeLabel: UILabel!
    

    // MARK: - Configure
    
    func configure(with title: String) {
       // self.ingredientLabel.text = title
    }
}
