//
//  CartManager.swift
//  Kebuke Ordering App
//
//  Created by 林上閔 on 4/27/25.
//
import Foundation

// MARK: - Shared Singleton 資料管理
// 讓 Menu 和 Cart 兩邊都共用同一個 CartManager，資料自然同步

class CartManager {
    
    // 這樣全App只有一個 CartManager
    static let shared = CartManager()
    
    private init() {}
    
    // cartItems 是 read-only（外面只能讀不能改）
    private(set) var cartItems: [OrderItem] = []
    
    // 新增訂單
    func add(item: OrderItem) {
        cartItems.append(item)
    }
    
    func clear() {
        cartItems.removeAll()
    }
}
