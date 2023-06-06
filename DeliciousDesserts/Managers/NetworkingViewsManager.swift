//
//  NetworkingViewsManager.swift
//  DeliciousDesserts
//
//  Created by David Ruvinskiy on 6/5/23.
//

import UIKit

/// Provides functionality to manage various views that could be needed in the context of networking.
/// Includes methods to show and dismiss a loading view and an empty state view.
/// Requires a parent view controller. The views will be overlayed on top of the parent view controller's view.
class NetworkingViewsManager {
    private var loadingView = UIView()
    
    weak var parentViewController: UIViewController?
    
    init(parentViewController: UIViewController) {
        self.parentViewController = parentViewController
    }
    
    func showLoadingView() {
        guard let parentView = parentViewController?.view else { return }
        
        loadingView = UIView(frame: parentView.bounds)
        parentView.addSubview(loadingView)
        
        loadingView.backgroundColor = .systemBackground
        loadingView.alpha = 0
        
        UIView.animate(withDuration: 0.25) { self.loadingView.alpha = 0.8 }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        loadingView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.loadingView.removeFromSuperview()
            self.loadingView = UIView()
        }
    }
    
    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = EmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
}
