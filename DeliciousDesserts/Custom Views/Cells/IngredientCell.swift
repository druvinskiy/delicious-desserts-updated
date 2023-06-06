//
//  IngredientCell.swift
//  DeliciousDesserts
//
//  Created by David Ruvinskiy on 6/5/23.
//

import UIKit

class IngredientCell: UITableViewCell {
    
    static let reuseID = "IngredientCell"
    
    let ingredientLabel = DDBodyLabel(textAlignment: .left)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
    }
    
    func set(ingredient: Ingredient) {
        ingredientLabel.text = "\(ingredient.measurement) \(ingredient.name)"
    }
    
    private func configure() {
        selectionStyle = .none
        
        contentView.addSubViews(ingredientLabel)
        ingredientLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            ingredientLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            ingredientLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            ingredientLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
