//
//  EmptyStateView.swift
//  DeliciousDesserts
//
//  Created by David Ruvinskiy on 6/5/23.
//

import UIKit

class EmptyStateView: UIView {
    
    let messageLabel = DDTitleLabel(textAlignment: .center, fontSize: 24, textColor: .secondaryLabel)
    let logoImageView = UIImageView()
    
    init(message: String) {
        messageLabel.text = message
        
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .systemBackground
        addSubViews(messageLabel, logoImageView)
        configureMessageLabel()
        configureLogoImageView()
    }
    
    private func configureMessageLabel() {
        messageLabel.numberOfLines = 0
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let centerYAnchorConstant: CGFloat = -150
        let leadingAnchorConstant: CGFloat = 40
        let trailingPadding: CGFloat = -40
        let heightAnchorConstant: CGFloat = 200
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: centerYAnchorConstant),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leadingAnchorConstant),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: trailingPadding),
            messageLabel.heightAnchor.constraint(equalToConstant: heightAnchorConstant)
        ])
    }
    
    private func configureLogoImageView() {
        logoImageView.image = Images.placeholder
        logoImageView.alpha = 0.3
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let widthAndHeightAnchorMultiplier: CGFloat = 1.3
        let trailingPadding: CGFloat = 170
        let bottomPadding: CGFloat = 40
        
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: widthAndHeightAnchorMultiplier),
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: widthAndHeightAnchorMultiplier),
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: trailingPadding),
            logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottomPadding)
        ])
    }
}
