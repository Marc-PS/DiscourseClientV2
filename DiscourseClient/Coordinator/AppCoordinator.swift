//
//  AppCoordinator.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 01/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// Coordinator principal de la app. Encapsula todas las interacciones con la Window.
/// Tiene dos hijos, el topic list, y el categories list (uno por cada tab)
class AppCoordinator: Coordinator {
    let sessionAPI = SessionAPI()

    lazy var remoteDataManager: DiscourseClientRemoteDataManager = {
        let remoteDataManager = DiscourseClientRemoteDataManagerImpl(session: sessionAPI)
        return remoteDataManager
    }()

    lazy var localDataManager: DiscourseClientLocalDataManager = {
        let localDataManager = DiscourseClientLocalDataManagerImpl()
        return localDataManager
    }()

    lazy var dataManager: DiscourseClientDataManager = {
        let dataManager = DiscourseClientDataManager(localDataManager: self.localDataManager, remoteDataManager: self.remoteDataManager)
        return dataManager
    }()

    let window: UIWindow
    init(window: UIWindow) {
        self.window = window
    }

    override func start() {
        let tabBarController = UITabBarController()

        let topicsNavigationController = UINavigationController()
        let topicsCoordinator = TopicsCoordinator(presenter: topicsNavigationController,
                                                  topicsDataManager: dataManager,
                                                  topicDetailDataManager: dataManager,
                                                  addTopicDataManager: dataManager)
        addChildCoordinator(topicsCoordinator)
        topicsCoordinator.start()

        let categoriesNavigationController = UINavigationController()
        let categoriesCoordinator = CategoriesCoordinator(presenter: categoriesNavigationController, categoriesDataManager: dataManager)
        addChildCoordinator(categoriesCoordinator)
        categoriesCoordinator.start()

        let usersNavigationController = UINavigationController()
        let usersCoordinator = UsersCoordinator(presenter: usersNavigationController, usersDataManager: dataManager, userDataManager: dataManager)
        addChildCoordinator(usersCoordinator)
        usersCoordinator.start()

        tabBarController.tabBar.tintColor = .black
        tabBarController.viewControllers = [topicsNavigationController, usersNavigationController]
        tabBarController.tabBar.items?.first?.image = UIImage(named: "inicioUnselected")
        tabBarController.tabBar.items?.first?.selectedImage = UIImage(named: "inicio")
        tabBarController.tabBar.items?[1].image = UIImage(named: "usuariosUnselected")
        tabBarController.tabBar.items?[1].selectedImage = UIImage(named: "usuarios")
        tabBarController.tabBar.backgroundColor = UIColor(white: 248.0 / 255.0, alpha: 0.82)

        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        navBarAppearance.backgroundColor = UIColor(white: 248.0 / 255.0, alpha: 0.82)
        topicsNavigationController.navigationBar.standardAppearance = navBarAppearance
        usersNavigationController.navigationBar.standardAppearance = navBarAppearance
        topicsNavigationController.navigationBar.scrollEdgeAppearance = navBarAppearance
        usersNavigationController.navigationBar.scrollEdgeAppearance = navBarAppearance
        topicsNavigationController.navigationBar.prefersLargeTitles = true
        usersNavigationController.navigationBar.prefersLargeTitles = true
    }

    override func finish() {}
}
