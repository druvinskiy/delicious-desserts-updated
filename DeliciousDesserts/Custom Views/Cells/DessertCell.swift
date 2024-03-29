//
//  DessertCell.swift
//  DeliciousDesserts
//
//  Created by David Ruvinskiy on 6/5/23.
//

import UIKit
import SDWebImage

class DessertCell: UICollectionViewCell {
    static let reuseID = "DessertCell"
    
    let dessertImageView = UIImageView()
    let nameLabel = DDTitleLabel(textAlignment: .left, fontSize: 18, textColor: .white)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(dessert: Dessert) {
        dessertImageView.sd_setImage(with: URL(string:dessert.thumbnailUrl ?? ""), placeholderImage: Images.placeholder)
        nameLabel.text = dessert.name
    }
    
    private func configure() {
        let nameView = UIView()
        nameView.translatesAutoresizingMaskIntoConstraints = false
        nameView.backgroundColor = .gray.withAlphaComponent(0.7)
        nameView.addSubview(nameLabel)
        
        addSubViews(dessertImageView, nameView)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dessertImageView.pinToEdges(of: self)
        
        let nameViewHeightMultiplier: CGFloat = 0.1
        let nameLabelPadding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            nameView.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameView.bottomAnchor.constraint(equalTo: bottomAnchor),
            nameView.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: nameViewHeightMultiplier),
            
            nameLabel.leadingAnchor.constraint(equalTo: nameView.leadingAnchor, constant: nameLabelPadding),
            nameLabel.centerYAnchor.constraint(equalTo: nameView.centerYAnchor)
        ])
    }
}
