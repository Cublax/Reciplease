//
//  ListingViewController.swift
//  Reciplease
//
//  Created by Alexandre Quiblier on 08/10/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

final class ListingViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    var viewModel: ListingViewModel!
    
    private lazy var dataSource: ListingDataSource = {
        let dataSource = ListingDataSource()
        dataSource.imageProvider = ImageProvider()
        return dataSource
    }()
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        
        bind(to: dataSource)
        bind(to: viewModel)
        viewModel.viewDidLoad()
        
    }
    
    private func bind(to viewModel: ListingViewModel) {
        viewModel.recipes = { [weak self] recipes in
            DispatchQueue.main.async {
                self?.dataSource.update(with: recipes)
                self?.tableView.reloadData()
            }
        }
    }
    
    private func bind(to dataSource: ListingDataSource) {
        dataSource.didSelectItemAtIndex = viewModel.didSelectRecipe
    }
}

