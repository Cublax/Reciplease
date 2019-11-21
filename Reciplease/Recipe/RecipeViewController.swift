//
//  FavoriteViewController.swift
//  Reciplease
//
//  Created by Alexandre Quiblier on 01/10/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit
import CoreData

final class RecipeViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameNavigationBar: UINavigationItem!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var numberServingsLabel: UILabel!
    @IBOutlet weak var numberIngredientLabel: UILabel!
    
    @IBOutlet weak var numberLikesLabel: UILabel!
    @IBOutlet weak var preparationTimeLabel: UILabel!
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var getDirectionsButton: UIButton!
    
    // MARK: - Properties
    
    var recipe: VisibleRecipe?
    
    var viewModel: RecipeViewModel!
    
    private let dataSource = RecipeDataSource()
    
    var imageProvider: ImageProvider!
    
    private var cancellationToken: RequestCancellationToken!
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        
        bind(to: dataSource)
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    private func bind(to viewModel: RecipeViewModel) {
        viewModel.informations = { [weak self] item in
            DispatchQueue.main.async {
                self?.recipe = item
                self?.dataSource.update(with: item.ingredient)
                self?.configureImage(with: item.urlImage)
                self?.nameNavigationBar.title = item.name
                self?.numberServingsLabel.text = "\(item.servings)"
                self?.numberIngredientLabel.text = "\(item.ingredient.count)"
                self?.tableView.reloadData()
            }
        }
    }
    
    private func bind(to dataSource: RecipeDataSource) {
        
    }
    
    private func configureImage(with url: String) {
        cancellationToken = RequestCancellationToken()
        guard let url = URL(string: url) else { return }
        imageProvider?.setImage(for: url, cancelledBy: cancellationToken) { [weak self] image in
            self?.dishImageView.image = image
            self?.dishImageView.contentMode = .scaleAspectFit
        }
    }
    
    @IBAction func AddFavorite(_ sender: Any) {
        viewModel.addFavorite()
    }
    
    @IBAction func getDirectionsButton(_ sender: Any) {
        guard let url = URL(string: recipe!.urlRecipe) else { return }
        UIApplication.shared.open(url)
    }
}
