//
//  CartItemCell.swift
//  Kebuke Ordering App
//
//  Created by 林上閔 on 4/27/25.
//

import UIKit

class CartItemCell: UITableViewCell {
    
    private let drinkNameLabel = UILabel()
    private let optionLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        drinkNameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        drinkNameLabel.textColor = .accent
        optionLabel.font = UIFont.systemFont(ofSize: 14)
        optionLabel.textColor = .darkGray

        let stack = UIStackView(arrangedSubviews: [drinkNameLabel, optionLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .leading
        

        contentView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }

    func configure(with item: OrderItem) {
        drinkNameLabel.text = item.drink.name
        optionLabel.text = "容量: \(item.size) / 甜度: \(item.sweetness) / 冰度: \(item.ice)"
    }
}
