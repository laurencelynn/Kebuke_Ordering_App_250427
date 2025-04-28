//
//  AllOrdersViewController.swift
//  Kebuke Ordering App
//
//  Created by 林上閔 on 4/28/25.
//

import UIKit

class AllOrdersViewController: UIViewController {
    
    private var orders: [OrderRecord] = []
    
    // 建立 下拉式更新功能 的實例
    private let refreshControl = UIRefreshControl()
    
    private let tableView = UITableView()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "所有訂單"
        view.backgroundColor = .systemGroupedBackground
        setupTableView()
        fetchOrders()
        tableView.allowsSelection = false
    }
    
    // MARK: - setupTableView()
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
        tableView.register(AllOrderCell.self, forCellReuseIdentifier: "AllOrderCell")
        
        // 下拉會更新畫面
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    // MARK: - fetchOrders()
    private func fetchOrders() {
        let baseID = ""
        let tableName = "Orders"
        let apiKey = ""

        guard let url = URL(string: "https://api.airtable.com/v0/\(baseID)/\(tableName)") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("讀取失敗：\(error.localizedDescription)")
                return
            }
            guard let data = data else { return }
            do {
                // 接收資料並更新
                let decodedData = try JSONDecoder().decode(AirtableResponse.self, from: data)
                self?.orders = decodedData.records
                DispatchQueue.main.async {
                    // 更新 Data
                    self?.tableView.reloadData()
                    // 下拉時更新，在 fetchOrders() 結束時停止刷新
                    self?.refreshControl.endRefreshing()
                    // 在沒有訂單時顯示「目前沒有訂單」
                    self?.updateBackgroundView()
                }
                
                // 錯誤排查可用，顯示 Airtable 回傳的資料
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("收到的 JSON 資料：\n\(jsonString)")
                }
                
            } catch {
                print("解析失敗：\(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    // MARK: - refreshData() 下拉更新
    @objc private func refreshData() {
        fetchOrders()
    }
    
    // MARK: - upDateBackgroundView 在沒有訂單時顯示「目前沒有訂單」
    private func updateBackgroundView() {
        if orders.isEmpty {
            let label = UILabel()
            label.text = "目前沒有訂單"
            label.textAlignment = .center
            label.textColor = .gray
            label.font = UIFont.systemFont(ofSize: 16)
            tableView.backgroundView = label
        } else {
            tableView.backgroundView = nil
        }
    }
}

// MARK: - Table View Delegate
extension AllOrdersViewController: UITableViewDataSource, UITableViewDelegate {
    
    // Rows in Section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }

    // Cell for Row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AllOrderCell", for: indexPath) as? AllOrderCell else {
            return UITableViewCell()
        }
        let record = orders[indexPath.row]
        cell.configure(with: record)
        return cell
    }
}
