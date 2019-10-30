//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Alexandre Quiblier on 01/10/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var firstQuestionLabel: UILabel!
    @IBOutlet weak var addIngredientTextField: UITextField!
    @IBOutlet weak var addIngredientButton: UIButton!
    @IBOutlet weak var clearIngredientsButton: UIButton!
    @IBOutlet weak var searchForRecipeButton: UIButton!
    
    // MARK: - Properties
    
    var viewModel: SearchViewModel!
    
    private let dataSource = SearchDataSource()
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }

    private func bind(to searchViewModel: SearchViewModel) {
        viewModel.visibleItems = { [weak self] items in
            DispatchQueue.main.async {
                self?.dataSource.update(with: items)
                self?.tableView.reloadData()
            }
        }
    }
    
        // MARK: - Actions
    
    @IBAction func didPressAddButton(_ sender: Any) {
        guard let ingredient = addIngredientTextField.text else {return}
        viewModel.addIngredient(for: ingredient)
        addIngredientTextField.text = ""
    }
    @IBAction func didPressClearButton(_ sender: Any) {
        viewModel.clearIngredientList()
    }
    
    @IBAction func didPressSearchForRecipeButton(_ sender: Any) {
        viewModel.searchForIngredients()
        }
    }
    
    




