//
//  InstructionsCell.swift
//  DeliciousDesserts
//
//  Created by David Ruvinskiy on 6/5/23.
//

import UIKit

class InstructionsCell: UITableViewCell {
    
    static let reuseID = "InstructionsCell"
    
    let instructionsLabel = DDBodyLabel(textAlignment: .left)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
    }
    
    func set(details: DessertDetail) {
        instructionsLabel.text = details.instructions
    }
    
    private func configure() {
        selectionStyle = .none
        
        contentView.addSubViews(instructionsLabel)
        instructionsLabel.numberOfLines = 0
        instructionsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            instructionsLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            instructionsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            instructionsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            instructionsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
