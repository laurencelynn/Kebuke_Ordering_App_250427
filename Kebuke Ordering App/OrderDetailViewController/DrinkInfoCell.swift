//
//  DrinkInfoCell.swift
//  Kebuke Ordering App
//
//  Created by 林上閔 on 4/27/25.
//

import UIKit

// MARK: - Cell Used in OrderDetailController
class DrinkInfoCell: UITableViewCell {
    
    private let drinkImageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UITextView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        drinkImageView.contentMode = .scaleAspectFill
        drinkImageView.clipsToBounds = true
        drinkImageView.layer.cornerRadius = 12
        drinkImageView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.numberOfLines = 1
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = .accent
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        descriptionLabel.isScrollEnabled = true
        descriptionLabel.isEditable = false
        descriptionLabel.showsVerticalScrollIndicator = false
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = .darkGray
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(drinkImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            drinkImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            drinkImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            drinkImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            drinkImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.4),
            
            titleLabel.topAnchor.constraint(equalTo: drinkImageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: drinkImageView.trailingAnchor, constant: 12),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
            
        ])
    }
    
    // MARK: - Configure
    func configure(with drink: Drink?) {
        guard let drink = drink else { return }
        drinkImageView.image = UIImage(named: drink.imageName)
        titleLabel.text = drink.name
        descriptionLabel.text = drink.longIntroduction
    }
}

