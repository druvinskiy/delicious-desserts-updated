//
//  ErrorStateViewController.swift
//  DeliciousDesserts
//
//  Created by David Ruvinskiy on 6/6/23.
//

import UIKit

class EmptyStateViewController: UIViewController {
    
    var dessert: Dessert
    let error: Error
    
    lazy var networkingViewsManager = NetworkingViewsManager(parentViewController: self)
    
    init(dessert: Dessert, error: Error) {
        self.dessert = dessert
        self.error = error
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        showEmptyStateView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func configureViewController() {
        title = dessert.name
    }
    
    func showEmptyStateView() {
        var errorString = DDError.defaultError.description
        
        if let ddError = error as? DDError {
            errorString = ddError.description
        }
        
        networkingViewsManager.showEmptyStateView(with: errorString)
    }
}
