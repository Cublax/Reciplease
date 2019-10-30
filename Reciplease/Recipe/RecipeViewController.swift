//
//  FavoriteViewController.swift
//  Reciplease
//
//  Created by Alexandre Quiblier on 01/10/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit


final class RecipeViewController: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var numberLikesLabel: UILabel!
    @IBOutlet weak var preparationTimeLabel: UILabel!
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var dishNameLabel: UILabel!
    @IBOutlet weak var getDirectionsButton: UIButton!
    
    // MARK: - Properties

    var viewModel: RecipeViewModel!
    
    private let dataSource = RecipeDataSource()
    
    var imageProvider: ImageProvider!
    
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
            self?.dataSource.update(with: item.ingredient)
            self?.dishNameLabel.text = item.name
            //self?.configureImage(with: item.urlImage)
              self?.tableView.reloadData()
          }
      }
    }
    
    private func bind(to dataSource: RecipeDataSource) {
       
    }
    
//    private func configureImage(with url: String) {
//        cancellationToken = RequestCancellationToken()
//               imageProvider?.setImage(for: url, cancelledBy: cancellationToken) { (image) in
//                    self.dishImageView.image = image
//                    self.dishImageView.contentMode = .scaleAspectFill
//               }
//    }
    
    @IBAction func AddFavorite(_ sender: Any) {
        
    }
}

