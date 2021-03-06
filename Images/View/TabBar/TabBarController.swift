//
//  TabBarController.swift
//  Images
//
//  Created by Alice Romanova on 09.06.2022.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            generateNavigationController(rootViewController: Images(), title: "Images", image: UIImage(systemName: "photo")),
            generateNavigationController(rootViewController: Favorites(), title: "Favorites", image: UIImage(systemName: "heart.rectangle"))]
    }
    
    
    private func generateNavigationController(rootViewController: UIViewController, title: String?, image: UIImage?) -> UINavigationController {
        
        let navigationViewController = UINavigationController(rootViewController: rootViewController)
        
        navigationViewController.tabBarItem.title = title
        navigationViewController.tabBarItem.image = image
        
        return navigationViewController
    }
}
