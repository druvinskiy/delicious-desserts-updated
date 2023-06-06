//
//  DessertDetailViewController.swift
//  DeliciousDesserts
//
//  Created by David Ruvinskiy on 6/5/23.
//

import UIKit

class DessertDetailViewController: UITableViewController {
    
    var dessert: Dessert
    var details: DessertDetail
    let networkManager = NetworkManager()
    
    enum Section: Int, CaseIterable {
        case ingredients
        case instructions
        
        var headerName: String {
            switch self {
            case .ingredients:
                return String(localized: "header-view.ingredients-section.name")
            case .instructions:
                return String(localized: "header-view.instructions-section.name")
            }
        }
        
        func rowCount(for dessertDetail: DessertDetail) -> Int {
            switch self {
            case .ingredients:
                return dessertDetail.ingredients.count
            case .instructions:
                return 1
            }
        }
        
        func cell(for tableView: UITableView, at indexPath: IndexPath, with dessertDetail: DessertDetail) -> UITableViewCell {
            switch self {
            case .ingredients:
                let cell = tableView.dequeueReusableCell(withIdentifier: IngredientCell.reuseID) as! IngredientCell
                cell.set(ingredient: dessertDetail.ingredients[indexPath.row])
                return cell
            case .instructions:
                let cell = tableView.dequeueReusableCell(withIdentifier: InstructionsCell.reuseID) as! InstructionsCell
                cell.set(details: dessertDetail)
                return cell
            }
        }
    }
    
    init(dessert: Dessert, details: DessertDetail) {
        self.dessert = dessert
        self.details = details
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = dessert.name
    }
    
    func configureTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.sectionHeaderTopPadding = 0
        tableView.register(IngredientCell.self, forCellReuseIdentifier: IngredientCell.reuseID)
        tableView.register(InstructionsCell.self, forCellReuseIdentifier: InstructionsCell.reuseID)
    }
}

extension DessertDetailViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = Section(rawValue: section)!
        
        return section.rowCount(for: details)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = Section(rawValue: indexPath.section)!
        
        return section.cell(for: tableView, at: indexPath, with: details)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = Section(rawValue: section)!
        
        return HeaderView(name: section.headerName)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
