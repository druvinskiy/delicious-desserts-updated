//
//  HeaderView.swift
//  DeliciousDesserts
//
//  Created by David Ruvinskiy on 6/5/23.
//

import UIKit

class HeaderView: UIView {
    let nameLabel = DDTitleLabel(textAlignment: .left, fontSize: 16, textColor: .white)
    
    init(name: String) {
        nameLabel.text = name
        
        super.init(frame: .zero)
        configure()
    }
    
    func configure() {
        backgroundColor = .gray
        
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let nameLabelLeadingPadding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: nameLabelLeadingPadding),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
