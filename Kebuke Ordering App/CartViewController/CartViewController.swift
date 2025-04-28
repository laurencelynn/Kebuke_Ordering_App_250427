//
//  CartViewController.swift
//  Kebuke Ordering App
//
//  Created by 林上閔 on 4/27/25.
//

import UIKit

class CartViewController: UIViewController {
    

    // Cart Table View
    private let tableView = UITableView()
    
    // Confirm Button
    private let confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("確定送出", for: .normal)
        button.backgroundColor = .accentColor02
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 12
        return button
    }()

    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "購物車"
        view.backgroundColor = .accentColor03
        setupTableView()
        setupConfirmButton()
        tableView.allowsSelection = false
    }
    
    // MARK: - 從 Menu 切到 Cart 時，讓 CartView 自動刷新資料
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Set Up Table View
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CartItemCell.self, forCellReuseIdentifier: "CartItemCell")
    }
    
    // MARK: - Set Up Confirm Button
    private func setupConfirmButton() {
        view.addSubview(confirmButton)
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            confirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            confirmButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            confirmButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - confirmButtonTapped API 傳資料給 Airtable
    @objc private func confirmButtonTapped() {
        // 傳訂單給 Airtable
        guard !CartManager.shared.cartItems.isEmpty else {
                showAlert(title: "購物車是空的", message: "請先加入飲料再送出")
                return
            }
            
            // 送出每一杯訂單
            // 都會傳到 Airtable
            for item in CartManager.shared.cartItems {
                postOrderToAirtable(orderItem: item)
            }
            // 並清空購物車
            CartManager.shared.clear()
            // 並重新載入畫面
            tableView.reloadData()
            // 並顯示送出成功提示
            showAlert(title: "送出成功", message: "已成功送出訂單！")
    }
    
    //MARK: - Show Alert Message 送出訂單時使用
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    // MARK: - postOrderToAirtable 用 API 傳資料給 Airtable
    private func postOrderToAirtable(orderItem: OrderItem) {
        let baseID = ""
        let tableName = "Orders"
        let apiKey = ""
        

        guard let url = URL(string: "https://api.airtable.com/v0/\(baseID)/\(tableName)") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let fields: [String: Any] = [
            "DrinkName": orderItem.drink.name,
            "Size": orderItem.size,
            "Sweetness": orderItem.sweetness,
            "Ice": orderItem.ice
        ]

        let body: [String: Any] = [
            "fields": fields
        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
            request.httpBody = jsonData

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("送出失敗：\(error.localizedDescription)")
                    return
                }
                if let httpResponse = response as? HTTPURLResponse {
                    print("送出成功，狀態碼: \(httpResponse.statusCode)")
                    print(body) //
                }
                //
                if let data = data,
                   let errorMessage = String(data: data, encoding: .utf8) {
                    print("錯誤訊息: \(errorMessage)")
                }
            }
            task.resume()
        } catch {
            print("序列化失敗：\(error.localizedDescription)")
        }
    }
}

// MARK: - Cart Table View Delegate
extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    
    // Number of Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CartManager.shared.cartItems.count
    }
    
    // Cell for Row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartItemCell", for: indexPath) as? CartItemCell else {
            return UITableViewCell()
        }
        // 建立 Cart 內容的 Table View
        let item = CartManager.shared.cartItems[indexPath.row]
        cell.configure(with: item)
        return cell
    }
}
