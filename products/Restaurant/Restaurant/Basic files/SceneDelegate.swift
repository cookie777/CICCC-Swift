//
//  SceneDelegate.swift
//  Restaurant
//
//  Created by Takayuki Yamaguchi on 2021-01-14.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?
  
  // Create a TabBarItem to show badge(the number of order you did)
  var orderTabBarItem: UITabBarItem!
  @objc func updateOrderBadge(){
    switch MenuController.shared.order.menuItems.count{
    case 0:
      orderTabBarItem.badgeValue = nil
    case let count:
      orderTabBarItem.badgeValue = String(count)
    }

  }


  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

    guard let windowScene = (scene as? UIWindowScene) else { return }
    
  
    
    
    // Create basic controller views
    let menuNVC = UINavigationController(rootViewController: CategoryTableViewController())
    let orderNVC = UINavigationController(rootViewController: OrderTableViewController())
    
    let tabBarVC = UITabBarController()
    tabBarVC.viewControllers = [menuNVC, orderNVC]
    menuNVC.tabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 0)
    orderNVC.tabBarItem = UITabBarItem(tabBarSystemItem: .recents, tag: 1)

    window = UIWindow(windowScene: windowScene)
    window?.makeKeyAndVisible()
    window?.rootViewController = tabBarVC
    
    
    
    // Register to observer. Whenever order is change, it will update the badge.
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(updateOrderBadge),
      name: MenuController.orderUpdatedNotification,
      object: nil
    )
    // Assign custom baritem as right one.
    orderTabBarItem = orderNVC.tabBarItem
  }

  func sceneDidDisconnect(_ scene: UIScene) {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
  }

  func sceneDidBecomeActive(_ scene: UIScene) {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
  }

  func sceneWillResignActive(_ scene: UIScene) {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
  }

  func sceneWillEnterForeground(_ scene: UIScene) {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
  }

  func sceneDidEnterBackground(_ scene: UIScene) {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
  }
  


}

