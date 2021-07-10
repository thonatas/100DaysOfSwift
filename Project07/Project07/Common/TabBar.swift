//
//  TabBar.swift
//  AppAcademyChallenge
//
//  Created by Thonatas Borges on 14/06/21.
//

import UIKit

class TabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        setupTabBarController()
    }
    
    private func setupTabBarController() {
        modalPresentationStyle = .fullScreen
        modalTransitionStyle = .crossDissolve
        viewControllers = [
            createViewController(viewController: PetitionViewController(), title: "Top Rated", imageSystemNamed: "star", index: 0),
            createViewController(viewController: PetitionViewController(), title: "Most Recent", imageSystemNamed: "clock", index: 1)
        ]
        tabBar.tintColor = .black
    }
    
    private func createViewController(viewController: UIViewController, title: String, imageSystemNamed: String, index: Int) -> UINavigationController {
        viewController.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: imageSystemNamed), tag: index)
        viewController.navigationItem.title = title
        let navigationController = UINavigationController(rootViewController: viewController)
        let backBarButtonItem = UIButton(type: .system)
        backBarButtonItem.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        navigationController.navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(customView: backBarButtonItem)
        navigationController.navigationBar.prefersLargeTitles = true

        return navigationController
    }

}
