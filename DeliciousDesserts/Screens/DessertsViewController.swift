//
//  DessertsViewController.swift
//  DeliciousDesserts
//
//  Created by David Ruvinskiy on 6/5/23.
//

import UIKit

class DessertsViewController: UICollectionViewController {
    
    var desserts: [Dessert] = []
    let networkManager = NetworkManager()
    lazy var networkingViewsManager = NetworkingViewsManager(parentViewController: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureCollectionView()
        getDesserts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = String(localized: "desserts-view.navigation-item.title")
    }
    
    func configureCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        
        let width = view.bounds.width
        flowLayout.itemSize = CGSize(width: width, height: width)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(DessertCell.self, forCellWithReuseIdentifier: DessertCell.reuseID)
    }
    
    func getDesserts() {
        networkingViewsManager.showLoadingView()
        
        Task {
            do {
                let desserts = try await networkManager.fetchDesserts().sorted()
                networkingViewsManager.dismissLoadingView()
                updateUI(with: desserts)
            } catch {
                networkingViewsManager.dismissLoadingView()
                
                var errorString = DDError.defaultError.description
                
                if let ddError = error as? DDError {
                    errorString = ddError.description
                }
                
                networkingViewsManager.showEmptyStateView(with: errorString)
            }
        }
    }
    
    func getDetails(dessert: Dessert) {
        let endpoint = Endpoint.details(id: dessert.id).url
        networkingViewsManager.showLoadingView()
        
        /// Small delay to prevent a UI flash when dismissing the loading view and pushing the new view controller
        let delay = 0.2
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            Task {
                var viewControllerToPush: UIViewController
                
                do {
                    let details = try await self.networkManager.fetchDetails(endpoint: endpoint)
                    self.networkingViewsManager.dismissLoadingView()
                    
                    viewControllerToPush = DessertDetailViewController(dessert: dessert, details: details)
                    
                } catch {
                    self.networkingViewsManager.dismissLoadingView()
                    
                    viewControllerToPush = EmptyStateViewController(dessert: dessert, error: error)
                }
                
                self.navigationController?.pushViewController(viewControllerToPush, animated: true)
            }
        }
    }
    
    func updateUI(with desserts: [Dessert]) {
        self.desserts = desserts
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

// MARK: - Collection view methods
extension DessertsViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return desserts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DessertCell.reuseID, for: indexPath) as! DessertCell
        let dessert = desserts[indexPath.row]
        
        cell.set(dessert: dessert)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dessert = desserts[indexPath.row]
        getDetails(dessert: dessert)
    }
}
