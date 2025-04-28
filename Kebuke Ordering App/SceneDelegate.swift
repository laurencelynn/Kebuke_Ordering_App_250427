//
//  SceneDelegate.swift
//  Kebuke Ordering App
//
//  Created by 林上閔 on 4/26/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let menuVC = MenuViewController()
        let cartVC = CartViewController()
        let allOrdersVC = AllOrdersViewController()

        let tabBarController = UITabBarController()
        
        tabBarController.viewControllers = [
            UINavigationController(rootViewController: menuVC),
            UINavigationController(rootViewController: cartVC),
            UINavigationController(rootViewController: allOrdersVC)
        ]

        menuVC.tabBarItem = UITabBarItem(title: "菜單", image: UIImage(systemName: "menucard"), tag: 0)
        cartVC.tabBarItem = UITabBarItem(title: "購物車", image: UIImage(systemName: "cart"), tag: 1)
        allOrdersVC.tabBarItem = UITabBarItem(title: "所有訂單", image: UIImage(systemName: "list.bullet"), tag: 2)

        // 設定 TabBar 毛玻璃風格
        let appearance = UITabBarAppearance()
            appearance.configureWithDefaultBackground()
            appearance.backgroundEffect = UIBlurEffect(style: .light)
            appearance.backgroundColor = UIColor.white.withAlphaComponent(0.7)
            tabBarController.tabBar.standardAppearance = appearance
            tabBarController.tabBar.scrollEdgeAppearance = appearance
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
    }

}

