//
//  MenuViewController.swift
//  Kebuke Ordering App
//
//  Created by 林上閔 on 4/27/25.
//

import UIKit

class MenuViewController: UIViewController {

    // MARK: - 建立實例
    // 分類按鈕的 ScrollView
    private let categoryScrollView = UIScrollView()
    private let categoryStackView = UIStackView()

    // 飲料的 TableView
    private let tableView = UITableView()

    // 全部飲料資料
    private var drinks: [Drink] = []

    // 篩選後的飲料
    private var filteredDrinks: [Drink] = []

    // 當前選的分類
    private var selectedCategory: DrinkCategory = .classic
    
    // 購物車訂單
    private var cartItems: [OrderItem] = []

    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .accent
        setupCategoryScrollView()
        setupTableView()
        loadDrinkData()
        filterDrinks()
    }

    // MARK: - Set Up Category ScrollView & StackView
    private func setupCategoryScrollView() {
        categoryScrollView.showsHorizontalScrollIndicator = false
        categoryStackView.axis = .horizontal
        categoryStackView.spacing = 8
        categoryStackView.alignment = .fill
        categoryStackView.distribution = .fillProportionally
        categoryScrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(categoryScrollView)

        NSLayoutConstraint.activate([
            categoryScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            categoryScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoryScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoryScrollView.heightAnchor.constraint(equalToConstant: 50)
        ])

        categoryScrollView.addSubview(categoryStackView)
        categoryStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryStackView.topAnchor.constraint(equalTo: categoryScrollView.topAnchor),
            categoryStackView.bottomAnchor.constraint(equalTo: categoryScrollView.bottomAnchor),
            categoryStackView.leadingAnchor.constraint(equalTo: categoryScrollView.leadingAnchor, constant: 8),
            categoryStackView.trailingAnchor.constraint(equalTo: categoryScrollView.trailingAnchor, constant: -8),
            categoryStackView.heightAnchor.constraint(equalTo: categoryScrollView.heightAnchor)
        ])

        // MARK: - Category ScrollView Buttons
        for category in DrinkCategory.allCases {
            let button = UIButton(type: .system)
            button.setTitle(category.rawValue, for: .normal)
            button.setTitleColor(.accentColor03, for: .normal)
            button.backgroundColor = UIColor(red: 4/225, green: 60/225, blue: 84/225, alpha: 1)
            button.layer.cornerRadius = 20
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
//            button.layer.masksToBounds = true
//            button.layer.borderWidth = 1
//            button.layer.borderColor = UIColor.accentColor02.cgColor
            button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 12)
            button.addTarget(self, action: #selector(categoryButtonTapped(_:)), for: .touchUpInside)
            button.tag = category.hashValue
            categoryStackView.addArrangedSubview(button)
        }
    }

    // MARK: - Set Up TableView
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: categoryScrollView.bottomAnchor, constant: 12),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.rowHeight = 180
        tableView.backgroundColor = .accentColor03
        tableView.showsVerticalScrollIndicator = false
        tableView.register(MenuViewCell.self, forCellReuseIdentifier: MenuViewCell.identifier)
    }

    // MARK: - Load Drink Data
    private func loadDrinkData() {
        drinks = drinksData
    }

    // MARK: - 根據點選的 Button 顯示該分類飲料
    private func filterDrinks() {
        UIView.transition(with: tableView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.filteredDrinks = self.drinks.filter { $0.category == self.selectedCategory }
            self.tableView.reloadData()
        })
    }
    
    // MARK: - categoryButtonTapped
    @objc private func categoryButtonTapped(_ sender: UIButton) {
        if let newCategory = DrinkCategory.allCases.first(where: { $0.hashValue == sender.tag }) {
            selectedCategory = newCategory
            filterDrinks()
        }
    }
}

// MARK: - Table View Delegate

extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
    
    // Rows In Section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredDrinks.count
    }

    // Cell for Row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuViewCell.identifier, for: indexPath) as? MenuViewCell else {
            return UITableViewCell()
        }
        let drink = filteredDrinks[indexPath.row]
        cell.configure(with: drink)
        return cell
    }
    
    // Did Select Row
    // Present Modally to OrderDetailController
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let drink = filteredDrinks[indexPath.row]
        let orderDetailVC = OrderDetailViewController()
        orderDetailVC.drink = drink
        orderDetailVC.modalPresentationStyle = .automatic
        
        // 重要：設定 closure，加到共享的 Cart Manager
        orderDetailVC.onAddToCart = { [weak self] orderItem in
            // 資料會直接加到 CartManager 的 cartItems
            CartManager.shared.add(item: orderItem)
            print("目前購物車有 \(CartManager.shared.cartItems.count) 杯飲料")
            }
        
        self.present(orderDetailVC, animated: true, completion: nil)
    }
    
}

