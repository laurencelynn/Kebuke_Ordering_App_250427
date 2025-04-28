//
//  AllOrderCell.swift
//  Kebuke Ordering App
//
//  Created by 林上閔 on 4/28/25.
//

import UIKit

class AllOrderCell: UITableViewCell {
    
    private let titleLabel = UILabel()
    private let detailLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = .accent
        detailLabel.font = UIFont.systemFont(ofSize: 14)
        detailLabel.textColor = .darkGray

        let stack = UIStackView(arrangedSubviews: [titleLabel, detailLabel])
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

    func configure(with record: OrderRecord) {
        let name = record.fields.CustomerName ?? "未知訂購人"
        let drink = record.fields.DrinkName ?? "未知飲料"
        titleLabel.text = "\(name) 訂購了 \(drink)"
        
        let size = record.fields.Size ?? "-"
        let sweetness = record.fields.Sweetness ?? "-"
        let ice = record.fields.Ice ?? "-"
        detailLabel.text = "容量: \(size) / 甜度: \(sweetness) / 冰度: \(ice)"
    }
}
