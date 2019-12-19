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
    
    @IBOutlet weak var servingsNumberLabel: UILabel!
    @IBOutlet weak var ingredientsNumberLabel: UILabel!
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var dishNameLabel: UILabel!
    @IBOutlet weak var originRecipeLabel: UILabel!
    
    @IBOutlet weak var gradientView: GradientView!
    
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
        DispatchQueue.main.async {
            self.setupGradientView()
        }
        self.dishNameLabel.text = recipes.name
        self.originRecipeLabel.text = recipes.source
        self.servingsNumberLabel.text = "\(recipes.servings)"
        self.ingredientsNumberLabel.text = "\(recipes.ingredient.count)"
        cancellationToken = RequestCancellationToken()
        guard let url = URL(string: recipes.urlImage) else { return }
        imageProvider?.setImage(for: url, cancelledBy: cancellationToken) { [weak self] image in
            DispatchQueue.main.async {
                self?.dishImageView.image = image
                self?.dishImageView.contentMode = .scaleAspectFill
            }
        }
    }
    
    override func prepareForReuse() {
        cancellationToken = nil
        dishImageView.image = nil
        dishNameLabel.text = nil
        originRecipeLabel.text = nil
        ingredientsNumberLabel.text = nil
        servingsNumberLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupGradientView()
    }
    
    private func setupGradientView() {
        let endColor = UIColor.black
        let startColor = UIColor.clear
        gradientView.updateGradient(with: .vertical, colors: startColor, endColor)
    }
}


