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
    @IBOutlet weak var originRecipeLabel: UILabel!
    
    // MARK: - Private properties
    
    private var recipes: VisibleRecipe!
    
    private var imageProvider: ImageProvider?
    
    private var cancellationToken: RequestCancellationToken!
    
    // MARK: - Configure
    
    func configure(with recipes: VisibleRecipe, imageProvider: ImageProvider?) {
        self.recipes = recipes
        self.imageProvider = imageProvider
        configureCell()
    }
    
    func configureCell() {
        self.dishNameLabel.text = recipes.name
        self.originRecipeLabel.text = recipes.source
        cancellationToken = RequestCancellationToken()
        imageProvider?.setImage(for: recipes.urlImage, cancelledBy: cancellationToken) { (image) in
            DispatchQueue.main.async {
                self.dishImageView.image = image
                self.dishImageView.contentMode = .scaleAspectFill
            }
        }
    }
    
    override func prepareForReuse() {
        cancellationToken = nil
        dishImageView.image = nil
        dishNameLabel.text = nil
        originRecipeLabel.text = nil
    }
}


