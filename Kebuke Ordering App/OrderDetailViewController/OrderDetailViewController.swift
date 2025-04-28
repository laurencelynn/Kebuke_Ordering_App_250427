//
//  OrderDetailViewController.swift
//  Kebuke Ordering App
//
//  Created by 林上閔 on 4/27/25.
//

import UIKit

class OrderDetailViewController: UIViewController {
    
    var drink: Drink?
    
    // 宣告並利用這個 Closure 把訂單資料傳給 CartViewController
    var onAddToCart: ((OrderItem) -> Void)?

    // MARK: - Inset-Grouped Table View
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    // MARK: - addToCartButton
    private let addToCartButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("加入購物車", for: .normal)
            button.backgroundColor = UIColor(red: 4/225, green: 60/225, blue: 84/225, alpha: 1)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            button.layer.cornerRadius = 12
            return button
        }()
    
    // MARK: - 建立甜度冰塊 Array 實例 與 選中的選項
        private var selectedSize: String = "中杯"
        private var selectedSweetness: String = "微糖二分糖"
        private var selectedIce: String = "微冰"

        private let sizes = ["中杯", "大杯"]
        private let sweetnessLevels = ["正常糖", "少糖", "半糖", "微糖二分糖", "一分糖", "無糖"]
        private let iceLevels = ["正常冰", "少冰", "微冰", "去冰", "完全去冰", "常溫", "溫", "熱"]
    
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "訂購飲料"
        view.backgroundColor = .systemGroupedBackground
        setupTableView()
        setupAddToCartButton()
    }
   
    // MARK: - setupTableView
    private func setupTableView() {
            view.addSubview(tableView)
            tableView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.topAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        tableView.backgroundColor = .accentColor03
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(DrinkInfoCell.self, forCellReuseIdentifier: "DrinkInfoCell")
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "OptionCell")
        }
    
    // MARK: - setupAddToCartButton
    private func setupAddToCartButton() {
            view.addSubview(addToCartButton)
            addToCartButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                addToCartButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                addToCartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                addToCartButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
                addToCartButton.heightAnchor.constraint(equalToConstant: 50)
            ])
            addToCartButton.addTarget(self, action: #selector(addToCartTapped), for: .touchUpInside)
        }
    
    // MARK: - addToCartTapped
    @objc private func addToCartTapped() {
        // 準備好訂單資料
        guard let drink = drink else { return }
        let order = OrderItem(drink: drink, size: selectedSize, sweetness: selectedSweetness, ice: selectedIce)
        // 用 closure 傳 order 資料
        onAddToCart?(order)
        dismiss(animated: true)
        }
}

// MARK: - TableView Delegate
extension OrderDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    // Number of Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 // 每個 Section 只有一個選項
    }
    
    // Title for Header in Section
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return nil
        case 1: return "容量"
        case 2: return "甜度"
        case 3: return "冰度"
        default: return nil
        }
    }
    
    // Height for Row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 200 : 50
    }
    
    // Cell for Row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DrinkInfoCell", for: indexPath) as? DrinkInfoCell else {
                return UITableViewCell()
            }
            cell.configure(with: drink)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell", for: indexPath)
            cell.accessoryType = .disclosureIndicator
            switch indexPath.section {
            case 1:
                cell.textLabel?.text = selectedSize
            case 2:
                cell.textLabel?.text = selectedSweetness
            case 3:
                cell.textLabel?.text = selectedIce
            default:
                break
            }
            return cell
        }
    }
    
    // Did Select Row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 1:
            showOptions(title: "選擇容量", options: sizes) { selected in
                self.selectedSize = selected
                self.tableView.reloadSections([1], with: .automatic)
            }
        case 2:
            showOptions(title: "選擇甜度", options: sweetnessLevels) { selected in
                self.selectedSweetness = selected
                self.tableView.reloadSections([2], with: .automatic)
            }
        case 3:
            showOptions(title: "選擇冰度", options: iceLevels) { selected in
                self.selectedIce = selected
                self.tableView.reloadSections([3], with: .automatic)
            }
        default:
            break
        }
    }
    
    // MARK: - showOptions 接上面的選擇甜度冰塊
    private func showOptions(title: String, options: [String], completion: @escaping (String) -> Void) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        for option in options {
            alert.addAction(UIAlertAction(title: option, style: .default, handler: { _ in
                completion(option)
            }))
        }
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        present(alert, animated: true)
    }
}

