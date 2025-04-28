//
//  MenuViewCell.swift
//  Kebuke Ordering App
//
//  Created by 林上閔 on 4/27/25.
//

import UIKit

// MARK: - 自製飲料 Cell
class MenuViewCell: UITableViewCell {
    
    // MARK: - Identifier
    static let identifier = "MenuViewCell"
    
    // MARK: - drinkImageView
    private let drinkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.backgroundColor = UIColor.clear
        return imageView
    }()
    
    // MARK: - Drink Labels （對應 Text Stack）
    private let drinkNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = UIColor.accent
        return label
    }()
    
    private let briefLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor(red: 186/225, green: 148/225, blue: 92/225, alpha: 1)
        return label
    }()
    
    //MARK: -  container: UIView
    private let container: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.05
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 5
        return view
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.backgroundColor = UIColor.accentColor03
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setupLayout
    private func setupLayout() {
        // container
        contentView.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        container.addSubview(drinkImageView)
        
        // MARK: - drinkImageView Auto Layout
        drinkImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            drinkImageView.topAnchor.constraint(equalTo: container.topAnchor, constant: 12),
            drinkImageView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 12),
            drinkImageView.heightAnchor.constraint(equalToConstant: 60),
            drinkImageView.widthAnchor.constraint(equalTo: drinkImageView.heightAnchor),
            drinkImageView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -12)
        ])
        
        // MARK: - Text Stack
        let textStack = UIStackView(arrangedSubviews: [drinkNameLabel, briefLabel, priceLabel])
        textStack.axis = .vertical
        textStack.spacing = 4
        textStack.alignment = .leading
        
        container.addSubview(textStack)
        textStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textStack.leadingAnchor.constraint(equalTo: drinkImageView.trailingAnchor, constant: 12),
            textStack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12),
            textStack.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])
    }
    // MARK: - Configure
    func configure(with drink: Drink) {
        drinkNameLabel.text = drink.name
        briefLabel.text = drink.briefIntroduction
        priceLabel.text = "M: \(drink.mediumPrice)  L: \(drink.largePrice)"
        
        if let image = UIImage(named: drink.imageName) {
            UIView.transition(with: drinkImageView, duration: 0.5, options: .transitionCrossDissolve, animations: {
                self.drinkImageView.image = image
            }, completion: nil)
        } else {
            drinkImageView.image = nil // 預防錯誤
        }
    }
}

