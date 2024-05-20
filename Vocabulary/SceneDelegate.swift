//
//  SceneDelegate.swift
//  Vocabulary
//
//  Created by 김시종 on 5/13/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        
        let tabBarVC = UITabBarController()
        
        let addBookVC = BookCaseViewController()
        addBookVC.tabBarItem = UITabBarItem(title: "단어장", image: UIImage(systemName: "book.pages")?.withTintColor(.white, renderingMode: .alwaysOriginal), selectedImage: UIImage(systemName: "book.pages.fill"))
        
        let addVocaVC = AddVocaViewController()
        addVocaVC.tabBarItem = UITabBarItem(title: "단어 추가", image: UIImage(systemName: "pencil")?.withTintColor(.white, renderingMode: .alwaysOriginal), selectedImage: UIImage(systemName: "pencil.circle.fill"))
        
        let gameMainPageVC = GameMainPageViewController()
        gameMainPageVC.tabBarItem = UITabBarItem(title: "단어 퀴즈", image: UIImage(systemName: "gamecontroller")?.withTintColor(.white, renderingMode: .alwaysOriginal), selectedImage: UIImage(systemName: "gamecontroller.fill"))
        
        let calenderVC = CalenderViewController()
        calenderVC.tabBarItem = UITabBarItem(title: "캘린더", image: UIImage(systemName: "calendar.circle")?.withTintColor(.white, renderingMode: .alwaysOriginal), selectedImage: UIImage(systemName: "calendar.circle.fill"))
        
        let myPageVC = MyPageViewController()
        myPageVC.tabBarItem = UITabBarItem(title: "마이페이지", image: UIImage(systemName: "person.crop.circle")?.withTintColor(.white, renderingMode: .alwaysOriginal), selectedImage: UIImage(systemName: "person.crop.circle.fill"))
        
        tabBarVC.viewControllers = [addBookVC, addVocaVC, gameMainPageVC, calenderVC, myPageVC]
        tabBarVC.tabBar.backgroundColor = ThemeColor.mainColor
        tabBarVC.tabBar.itemPositioning = .centered
        tabBarVC.tabBar.tintColor = .white
        tabBarVC.tabBar.unselectedItemTintColor = .white
        
        let tabBar = tabBarVC.tabBar
        tabBar.layer.masksToBounds = true
        tabBar.layer.cornerRadius = 15
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        let backgroundView = UIView(frame: tabBar.bounds.insetBy(dx: -10, dy: -10))
        backgroundView.backgroundColor = ThemeColor.mainColor
        backgroundView.layer.cornerRadius = 15
        backgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        backgroundView.layer.masksToBounds = true
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        tabBar.insertSubview(backgroundView, at: 0)
        
        backgroundView.snp.makeConstraints {
            $0.edges.equalTo(tabBarVC.view.safeAreaLayoutGuide)
        }
        
        let normalAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let selectedAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        UITabBarItem.appearance().setTitleTextAttributes(normalAttributes, for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(selectedAttributes, for: .selected)
        
        self.window?.rootViewController = tabBarVC
        window?.makeKeyAndVisible()
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
        
        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    
}

